// Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: implementation_imports

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart'
    hide Enum, FunctionType, RecordType;
import 'package:json_serializable/src/constants.dart' show closureArg;
import 'package:json_serializable/src/decode_helper.dart';
import 'package:json_serializable/src/default_container.dart';
import 'package:json_serializable/src/enum_utils.dart';
import 'package:json_serializable/src/field_helpers.dart';
import 'package:json_serializable/src/helper_core.dart';
import 'package:json_serializable/src/json_key_utils.dart';
import 'package:json_serializable/src/lambda_result.dart';
import 'package:json_serializable/src/shared_checkers.dart';
import 'package:json_serializable/src/type_helper.dart';
import 'package:json_serializable/src/type_helper_ctx.dart';
import 'package:json_serializable/src/type_helpers/config_types.dart';
import 'package:json_serializable/src/type_helpers/json_converter_helper.dart';
import 'package:json_serializable/src/type_helpers/to_from_string.dart';
import 'package:json_serializable/src/unsupported_type_error.dart';
import 'package:json_serializable/src/utils.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

final _validJsIdentifier = RegExp(r'^[A-Za-z_$][A-Za-z0-9_$]*$');
final _simpleDartIdentifier = RegExp(r'^[A-Za-z_$][A-Za-z0-9_$]*$');

const _coreListChecker = TypeChecker.fromUrl('dart:core#List');
const _coreSetChecker = TypeChecker.fromUrl('dart:core#Set');
const _coreDurationChecker = TypeChecker.fromUrl('dart:core#Duration');

const _jsObjectKeysHelperDeclaration = '''
@JS('Object.keys')
external JSArray<JSString> _\$jsObjectKeys(JSObject obj);''';

class JsClassGenerationResult {
  final Set<String> dartImports;
  final Set<String> packageImports;
  final Set<String> relativeImports;
  final List<Spec> specs;
  final Set<String> addedMembers;

  JsClassGenerationResult({
    required this.dartImports,
    required this.packageImports,
    required this.relativeImports,
    required this.specs,
    required this.addedMembers,
  });
}

class JsGeneratorHelper extends HelperCore {
  final _addedMembers = <String>{};
  final _dartImports = <String>{'dart:js_interop'};
  final _packageImports = <String>{};
  final _relativeImports = <String>{};

  JsGeneratorHelper(
    ClassConfig baseConfig,
    ClassElement element,
    ConstantReader annotation,
  ) : super(
        element,
        mergeConfig(baseConfig, annotation, classElement: element),
      );

  @override
  void addMember(String memberContent) {
    if (memberContent.trim().isNotEmpty) {
      _addedMembers.add(memberContent.trim());
    }
  }

  @override
  Iterable<TypeHelper> get allTypeHelpers => const [];

  JsClassGenerationResult generateClass() =>
      runWithTargetLibrary(element.library, _generateClassInternal);

  JsClassGenerationResult _generateClassInternal() {
    if (element.isPrivate) {
      throw InvalidGenerationSourceError(
        '`@JsonSerializable` classes used with `js_codable` must be public '
        'because `.js_codable.dart` is generated as a standalone library.',
        element: element,
      );
    }

    if (config.genericArgumentFactories) {
      throw InvalidGenerationSourceError(
        '`genericArgumentFactories: true` is not supported by `js_codable` '
        'because `dart:js_interop` extension types cannot declare unbounded '
        'generic external members or runtime factory callbacks.',
        element: element,
      );
    }

    if (config.createFactory || config.createToJson) {
      _recordLibraryImport(element.library);
    }
    for (final ann in element.metadata.annotations) {
      _collectTypeImports(ann.computeConstantValue()?.type);
    }
    for (final conv in config.converters) {
      _collectTypeImports(conv.type);
    }

    final processed = _processFields();
    final decodeFields = processed.decodeFields;
    final encodeFields = processed.encodeFields;
    final allJsFields = <FieldElement>[
      ...decodeFields,
      for (final f in encodeFields)
        if (!decodeFields.contains(f)) f,
    ];

    for (final field in allJsFields) {
      _collectFieldImports(field);
    }

    final specs = <Spec>[
      _buildExtensionType(
        decodeFields: decodeFields,
        encodeFields: encodeFields,
      ),
      if (config.createToJson) _buildDartExtension(),
      ?processed.fromJsMethod,
      if (config.createToJson) _buildToJsFunction(encodeFields),
    ];

    return JsClassGenerationResult(
      dartImports: _dartImports,
      packageImports: _packageImports,
      relativeImports: _relativeImports,
      specs: specs,
      addedMembers: _addedMembers,
    );
  }

  ({
    List<FieldElement> decodeFields,
    List<FieldElement> encodeFields,
    Method? fromJsMethod,
  })
  _processFields() {
    final sortedFields = createSortedFieldSet(
      element,
      keepObjectMemberOverride: hasJsonKeyAnnotation,
    );
    recordFieldOverrideChains(element, sortedFields);
    final unavailableReasons = <String, String>{};

    final accessibleFields = sortedFields.fold<Map<String, FieldElement>>(
      <String, FieldElement>{},
      (map, field) {
        final jsonKey = jsonKeyFor(field);
        if (!field.isPublic) {
          unavailableReasons[field.name!] =
              'It is assigned to a private field.';
        } else if (field.getter == null) {
          assert(field.setter != null);
          unavailableReasons[field.name!] =
              'Setter-only properties are not supported.';
          log.warning('Setters are ignored: ${element.name}.${field.name}');
        } else if (jsonKey.explicitNoFromJson) {
          unavailableReasons[field.name!] =
              'It is assigned to a field not meant to be used in fromJson.';
        } else {
          assert(!map.containsKey(field.name));
          map[field.name!] = field;
        }

        return map;
      },
    );

    final explicitToJsonFields = sortedFields
        .where(
          (f) =>
              f.isPublic && f.getter != null && jsonKeyFor(f).explicitYesToJson,
        )
        .toList();

    var fieldsToUse = accessibleFields.values.toList();
    Method? fromJsMethod;

    if (config.createFactory) {
      final factoryData = _buildFromJsFactoryData(
        accessibleFields,
        unavailableReasons,
      );
      fieldsToUse = factoryData.fieldsToUse;
      fromJsMethod = factoryData.fromJsMethod;
    }

    final decodeFields = List<FieldElement>.of(fieldsToUse);

    final encodeCandidates = List<FieldElement>.of(fieldsToUse);
    for (final candidate in explicitToJsonFields) {
      if (!encodeCandidates.contains(candidate)) {
        encodeCandidates.add(candidate);
      }
    }

    encodeCandidates.sort(
      (a, b) => sortedFields.indexOf(a).compareTo(sortedFields.indexOf(b)),
    );

    final encodeFields = encodeCandidates
        .where((f) => f.isPublic && !jsonKeyFor(f).explicitNoToJson)
        .toList();

    _checkForDuplicateKeys(encodeFields);

    return (
      decodeFields: decodeFields,
      encodeFields: encodeFields,
      fromJsMethod: fromJsMethod,
    );
  }

  ({List<FieldElement> fieldsToUse, Method fromJsMethod})
  _buildFromJsFactoryData(
    Map<String, FieldElement> accessibleFields,
    Map<String, String> unavailableReasons,
  ) {
    final ctor = constructorByName(element, config.constructor);
    if (ctor.isPrivate) {
      throw InvalidGenerationSourceError(
        'Constructor `${element.name}.${config.constructor}` is private and '
        'cannot be invoked from the standalone `.js_codable.dart` library.',
        element: ctor,
      );
    }

    Expression deserializeFun(
      String paramOrFieldName, {
      FormalParameterElement? ctorParam,
    }) => _deserializeForField(
      accessibleFields[paramOrFieldName]!,
      ctorParam: ctorParam,
    );

    final writableFields = accessibleFields.values
        .where((fe) {
          final setter = element.lookUpSetter(
            name: fe.name!,
            library: element.library,
          );
          return setter != null && setter.isPublic;
        })
        .map((fe) => fe.name!)
        .toList();

    final data = writeConstructorInvocation(
      element,
      config.constructor,
      accessibleFields.keys,
      writableFields,
      unavailableReasons,
      deserializeFun,
    );

    final fieldsToUse = accessibleFields.entries
        .where((e) => data.usedCtorParamsAndFields.contains(e.key))
        .map((e) => e.value)
        .toList();

    _checkForDuplicateKeys(fieldsToUse);

    final bodyExpr = data.fieldsToSet.isEmpty
        ? data.content
        : data.fieldsToSet.fold<Expression>(
            data.content,
            (current, field) => current
                .cascade(field)
                .assign(
                  CodeExpression(
                    Code('${toCodeString(deserializeFun(field))} '),
                  ),
                ),
          );

    final className = element.name!;
    final fromJsMethod = Method(
      (m) => m
        ..name = '\$${className}FromJs'
        ..returns = refer(targetClassReference)
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'js'
              ..type = refer('${className}JS'),
          ),
        )
        ..lambda = true
        ..body = bodyExpr.code,
    );

    return (fieldsToUse: fieldsToUse, fromJsMethod: fromJsMethod);
  }

  void _checkForDuplicateKeys(Iterable<FieldElement> fields) {
    final set = <String>{};
    for (final fe in fields) {
      final jsonKey = nameAccess(fe);
      if (!set.add(jsonKey)) {
        throw InvalidGenerationSourceError(
          'More than one field has the JSON key for name "$jsonKey".',
          element: fe,
        );
      }
    }
  }

  ExtensionType _buildExtensionType({
    required List<FieldElement> decodeFields,
    required List<FieldElement> encodeFields,
  }) {
    final className = element.name!;
    final factoryFields = encodeFields
        .where((f) => _validJsIdentifier.hasMatch(nameAccess(f)))
        .toList();
    final nonIdentifierEncodeFields = encodeFields
        .where((f) => !_validJsIdentifier.hasMatch(nameAccess(f)))
        .toList();

    final getterFields = <FieldElement>[
      ...decodeFields,
      for (final f in encodeFields)
        if (!decodeFields.contains(f)) f,
    ];

    final constructors = <Constructor>[
      if (config.createToJson) ...[
        _buildExternalFactoryConstructor(factoryFields),
        Constructor(
          (c) => c
            ..name = 'fromDart'
            ..factory = true
            ..requiredParameters.add(
              Parameter(
                (p) => p
                  ..name = 'instance'
                  ..type = refer(targetClassReference),
              ),
            )
            ..lambda = true
            ..body = refer('\$${className}ToJs').call([refer('instance')]).code,
        ),
      ],
    ];

    final methods = _buildExtensionTypeMethods(
      className: className,
      getterFields: getterFields,
      nonIdentifierEncodeFields: nonIdentifierEncodeFields,
    );

    return ExtensionType((b) {
      if (element.documentationComment case final doc? when doc.isNotEmpty) {
        b.docs.add(doc);
      }
      b
        ..name = '${className}JS'
        ..constant = true
        ..primaryConstructorName = '_'
        ..representationDeclaration = RepresentationDeclaration(
          (r) => r
            ..name = '_'
            ..declaredRepresentationType = refer('JSObject'),
        )
        ..implements.add(refer('JSObject'))
        ..constructors.addAll(constructors)
        ..methods.addAll(methods);
    });
  }

  Constructor _buildExternalFactoryConstructor(
    List<FieldElement> factoryFields,
  ) => Constructor(
    (c) => c
      ..external = true
      ..factory = true
      ..optionalParameters.addAll([
        for (final field in factoryFields)
          Parameter((p) {
            final wireName = nameAccess(field);
            final wireType = _encodeExternalWireTypeForField(field);
            final isNullable = wireType.endsWith('?');
            p
              ..name = field.name!
              ..named = true
              ..required = !isNullable || _hasExplicitIncludeIfNullTrue(field)
              ..type = refer(wireType);
            if (wireName != field.name!) {
              p.annotations.add(
                refer('JS').call([CodeExpression(Code(safeNameAccess(field)))]),
              );
            }
          }),
      ]),
  );

  List<Method> _buildExtensionTypeMethods({
    required String className,
    required List<FieldElement> getterFields,
    required List<FieldElement> nonIdentifierEncodeFields,
  }) => <Method>[
    for (final field in getterFields) ...[
      _buildJsGetter(field),
      if (_isMutableField(field) && !nonIdentifierEncodeFields.contains(field))
        _buildJsSetter(field),
    ],
    if (config.createToJson)
      for (final field in nonIdentifierEncodeFields) _buildJsSetter(field),
    if (config.createFactory)
      Method(
        (m) => m
          ..name = 'toDart'
          ..returns = refer(targetClassReference)
          ..lambda = true
          ..body = refer('\$${className}FromJs').call([refer('this')]).code,
      ),
  ];

  bool _isMutableField(FieldElement field) {
    if (field.isFinal || field.isConst) return false;
    final setter = element.lookUpSetter(
      name: field.name!,
      library: element.library,
    );
    return setter != null && setter.isPublic;
  }

  bool _hasExplicitIncludeIfNullTrue(FieldElement field) {
    for (final f in fieldHierarchyFor(field)) {
      final ann = jsonKeyAnnotation(f);
      if (!ann.isNull) {
        final reader = ann.read('includeIfNull');
        if (!reader.isNull) {
          return reader.boolValue;
        }
      }
    }
    return false;
  }

  Method _buildJsGetter(FieldElement field) {
    final wireName = nameAccess(field);
    final wireType = _decodeExternalWireTypeForField(field);
    final doc =
        field.documentationComment ?? field.getter?.documentationComment;
    if (wireName.contains('.')) {
      _dartImports.add('dart:js_interop_unsafe');
      return Method((m) {
        if (doc != null && doc.isNotEmpty) {
          m.docs.add(doc);
        }
        m
          ..type = MethodType.getter
          ..name = field.name!
          ..returns = refer(wireType)
          ..lambda = true
          ..body = _buildDotGetterExpression(field, wireType).code;
      });
    }

    return Method((m) {
      if (doc != null && doc.isNotEmpty) {
        m.docs.add(doc);
      }
      m
        ..external = true
        ..type = MethodType.getter
        ..name = field.name!
        ..returns = refer(wireType);
      if (wireName != field.name!) {
        m.annotations.add(
          refer('JS').call([CodeExpression(Code(safeNameAccess(field)))]),
        );
      }
    });
  }

  Method _buildJsSetter(FieldElement field) {
    final wireName = nameAccess(field);
    final wireType = config.createToJson
        ? _encodeExternalWireTypeForField(field)
        : _decodeExternalWireTypeForField(field);
    if (wireName.contains('.')) {
      _dartImports.add('dart:js_interop_unsafe');
      return Method(
        (m) => m
          ..type = MethodType.setter
          ..name = field.name!
          ..requiredParameters.add(
            Parameter(
              (p) => p
                ..name = 'value'
                ..type = refer(wireType),
            ),
          )
          ..lambda = true
          ..body = _buildDotSetterExpression(field, wireType).code,
      );
    }

    return Method((m) {
      m
        ..external = true
        ..type = MethodType.setter
        ..name = field.name!
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'value'
              ..type = refer(wireType),
          ),
        );
      if (wireName != field.name!) {
        m.annotations.add(
          refer('JS').call([CodeExpression(Code(safeNameAccess(field)))]),
        );
      }
    });
  }

  Expression _buildDotGetterExpression(FieldElement field, String wireType) {
    final isNullable = wireType.endsWith('?');
    final baseType = isNullable
        ? wireType.substring(0, wireType.length - 1)
        : wireType;
    final keyExpr = CodeExpression(
      Code(safeNameAccess(field)),
    ).property('toJS');

    Expression getProp(String jsBoxedBase) {
      final typeArg = isNullable ? '$jsBoxedBase?' : jsBoxedBase;
      return refer(
        '_',
      ).property('getProperty').call([keyExpr], {}, [refer(typeArg)]);
    }

    return switch (baseType) {
      'String' =>
        isNullable
            ? getProp('JSString').nullSafeProperty('toDart')
            : getProp('JSString').property('toDart'),
      'int' =>
        isNullable
            ? getProp('JSNumber').nullSafeProperty('toDartInt')
            : getProp('JSNumber').property('toDartInt'),
      'double' || 'num' =>
        isNullable
            ? getProp('JSNumber').nullSafeProperty('toDartDouble')
            : getProp('JSNumber').property('toDartDouble'),
      'bool' =>
        isNullable
            ? getProp('JSBoolean').nullSafeProperty('toDart')
            : getProp('JSBoolean').property('toDart'),
      _ => getProp(baseType),
    };
  }

  Expression _buildDotSetterExpression(FieldElement field, String wireType) {
    final isNullable = wireType.endsWith('?');
    final baseType = isNullable
        ? wireType.substring(0, wireType.length - 1)
        : wireType;
    final keyExpr = CodeExpression(
      Code(safeNameAccess(field)),
    ).property('toJS');
    final valRef = refer('value');

    final jsVal = switch (baseType) {
      'String' || 'int' || 'double' || 'num' || 'bool' =>
        isNullable ? valRef.nullSafeProperty('toJS') : valRef.property('toJS'),
      _ => valRef,
    };

    return refer('_').property('setProperty').call([keyExpr, jsVal]);
  }

  Extension _buildDartExtension() {
    final className = element.name!;
    return Extension(
      (e) => e
        ..name = '${className}JsCodableExtension'
        ..on = refer(targetClassReference)
        ..methods.add(
          Method(
            (m) => m
              ..name = 'toJs'
              ..returns = refer('${className}JS')
              ..lambda = true
              ..body = refer('\$${className}ToJs').call([refer('this')]).code,
          ),
        ),
    );
  }

  Method _buildToJsFunction(List<FieldElement> encodeFields) {
    final className = element.name!;
    final factoryFields = encodeFields
        .where((f) => _validJsIdentifier.hasMatch(nameAccess(f)))
        .toList();
    final cascadeFields = encodeFields
        .where((f) => !_validJsIdentifier.hasMatch(nameAccess(f)))
        .toList();

    final namedArgs = <String, Expression>{
      for (final field in factoryFields)
        field.name!: _serializeForField(
          field,
          refer('instance').property(field.name!),
        ),
    };

    var bodyExpr = refer('${className}JS').call([], namedArgs);

    if (cascadeFields.isNotEmpty) {
      bodyExpr = cascadeFields.fold<Expression>(bodyExpr, (current, field) {
        final serialized = toCodeString(
          _serializeForField(field, refer('instance').property(field.name!)),
        );
        return current
            .cascade(field.name!)
            .assign(CodeExpression(Code('$serialized ')));
      });
    }

    return Method(
      (m) => m
        ..name = '\$${className}ToJs'
        ..returns = refer('${className}JS')
        ..requiredParameters.add(
          Parameter(
            (p) => p
              ..name = 'instance'
              ..type = refer(targetClassReference),
          ),
        )
        ..lambda = true
        ..body = bodyExpr.code,
    );
  }

  DartType _decodeTargetTypeForField(
    FieldElement field, {
    FormalParameterElement? ctorParam,
  }) {
    final resolvedCtorParam =
        ctorParam ??
        config.ctorParams.where((p) => p.name == field.name).firstOrNull;
    return resolvedCtorParam?.type ?? field.type;
  }

  String _decodeExternalWireTypeForField(FieldElement field) {
    final targetType = _decodeTargetTypeForField(field);
    final jsonKey = jsonKeyFor(field);
    final defaultValue = jsonKey.defaultValue;
    final ctx = getHelperContext(field);

    final fromJsonData = ctx.deserializeConvertData;
    if (fromJsonData != null) {
      final wireType = fromJsonData.paramType;
      final base = _converterWireToJsExternalBaseType(wireType);
      final isNullable =
          targetType.isNullableType ||
          defaultValue != null ||
          wireType.isNullableType;
      return _withNullability(base, isNullable);
    }

    final converter = typeConverter(targetType, ctx);
    if (converter != null) {
      final wireType = converter.jsonType;
      final base = _converterWireToJsExternalBaseType(wireType);
      final isNullable =
          targetType.isNullableType ||
          defaultValue != null ||
          wireType.isNullableType;
      return _withNullability(base, isNullable);
    }

    final base = _jsExternalBaseType(targetType, ctx);
    final isNullable =
        targetType.isNullableType ||
        defaultValue != null ||
        enumFieldWithNullInEncodeMap(targetType) == true;
    return _withNullability(base, isNullable);
  }

  String _encodeExternalWireTypeForField(FieldElement field) {
    final targetType = field.type;
    final ctx = getHelperContext(field);

    final toJsonData = ctx.serializeConvertData;
    if (toJsonData != null) {
      final wireType = toJsonData.returnType;
      final base = _converterWireToJsExternalBaseType(wireType);
      final isNullable = targetType.isNullableType || wireType.isNullableType;
      return _withNullability(base, isNullable);
    }

    final converter = typeConverter(targetType, ctx);
    if (converter != null) {
      final wireType = converter.jsonType;
      final base = _converterWireToJsExternalBaseType(wireType);
      final isNullable = targetType.isNullableType || wireType.isNullableType;
      return _withNullability(base, isNullable);
    }

    final base = _jsExternalBaseType(targetType, ctx);
    final isNullable =
        targetType.isNullableType ||
        enumFieldWithNullInEncodeMap(targetType) == true;
    return _withNullability(base, isNullable);
  }

  String _converterWireToJsExternalBaseType(DartType wireType) {
    final nonNull = wireType.promoteNonNullable();
    if (nonNull.isDartCoreString) return 'String';
    if (nonNull.isDartCoreInt) return 'int';
    if (nonNull.isDartCoreDouble) return 'double';
    if (nonNull.isDartCoreNum) return 'num';
    if (nonNull.isDartCoreBool) return 'bool';
    if (_isJsInteropExtensionType(nonNull)) return typeToCode(nonNull);
    if (_isJsCodableClass(nonNull)) return '${nonNull.element!.name!}JS';
    if (coreMapTypeChecker.isAssignableFromType(nonNull)) return 'JSObject';
    if (coreIterableTypeChecker.isAssignableFromType(nonNull)) {
      return 'JSArray<JSAny?>';
    }
    return 'JSAny?';
  }

  String _jsExternalBaseType(DartType targetType, TypeHelperCtx ctx) {
    final nonNull = targetType.promoteNonNullable();

    if (typeConverter(targetType, ctx) case final converter?) {
      return _converterWireToJsExternalBaseType(converter.jsonType);
    }

    if (nonNull.isDartCoreString ||
        coreDateTimeTypeChecker.isExactlyType(nonNull) ||
        coreUriTypeChecker.isExactlyType(nonNull) ||
        coreBigIntTypeChecker.isExactlyType(nonNull)) {
      return 'String';
    }
    if (nonNull.isDartCoreInt || _coreDurationChecker.isExactlyType(nonNull)) {
      return 'int';
    }
    if (nonNull.isDartCoreDouble) return 'double';
    if (nonNull.isDartCoreNum) return 'num';
    if (nonNull.isDartCoreBool) return 'bool';
    if (_isJsInteropExtensionType(nonNull)) return typeToCode(nonNull);

    if (nonNull.isEnum) {
      return _enumExternalBaseType(nonNull);
    }

    if (_isJsCodableClass(nonNull)) {
      return '${nonNull.element!.name!}JS';
    }

    if (coreIterableTypeChecker.isAssignableFromType(nonNull)) {
      final itemType = coreIterableGenericType(nonNull);
      final itemBoxed = _jsBoxedType(itemType, ctx);
      return 'JSArray<$itemBoxed>';
    }

    if (coreMapTypeChecker.isAssignableFromType(nonNull)) {
      return 'JSObject';
    }

    if (_isDynamicOrObject(nonNull)) {
      return 'JSAny?';
    }

    throw UnsupportedTypeError(targetType, fieldElementName(ctx));
  }

  String _jsBoxedType(DartType targetType, TypeHelperCtx ctx) {
    final base = _jsBoxedBaseType(targetType, ctx);
    final converter = typeConverter(targetType, ctx);
    final isNullable =
        targetType.isNullableType ||
        (converter != null && converter.jsonType.isNullableType) ||
        enumFieldWithNullInEncodeMap(targetType) == true;
    return _withNullability(base, isNullable);
  }

  String _jsBoxedBaseType(DartType targetType, TypeHelperCtx ctx) {
    final nonNull = targetType.promoteNonNullable();

    if (typeConverter(targetType, ctx) case final converter?) {
      return _converterWireToJsBoxedBaseType(converter.jsonType);
    }

    if (nonNull.isDartCoreString ||
        coreDateTimeTypeChecker.isExactlyType(nonNull) ||
        coreUriTypeChecker.isExactlyType(nonNull) ||
        coreBigIntTypeChecker.isExactlyType(nonNull)) {
      return 'JSString';
    }
    if (nonNull.isDartCoreInt ||
        nonNull.isDartCoreDouble ||
        nonNull.isDartCoreNum ||
        _coreDurationChecker.isExactlyType(nonNull)) {
      return 'JSNumber';
    }
    if (nonNull.isDartCoreBool) {
      return 'JSBoolean';
    }
    if (_isJsInteropExtensionType(nonNull)) {
      return typeToCode(nonNull);
    }
    if (nonNull.isEnum) {
      final enumBase = _enumExternalBaseType(nonNull);
      return switch (enumBase) {
        'String' => 'JSString',
        'int' => 'JSNumber',
        _ => 'JSAny',
      };
    }
    if (_isJsCodableClass(nonNull)) {
      return '${nonNull.element!.name!}JS';
    }
    if (coreIterableTypeChecker.isAssignableFromType(nonNull)) {
      final itemType = coreIterableGenericType(nonNull);
      final itemBoxed = _jsBoxedType(itemType, ctx);
      return 'JSArray<$itemBoxed>';
    }
    if (coreMapTypeChecker.isAssignableFromType(nonNull)) {
      return 'JSObject';
    }
    if (nonNull.isDartCoreObject || nonNull is DynamicType) {
      return 'JSAny?';
    }

    throw UnsupportedTypeError(targetType, fieldElementName(ctx));
  }

  String _converterWireToJsBoxedBaseType(DartType wireType) {
    final nonNull = wireType.promoteNonNullable();
    if (nonNull.isDartCoreString) return 'JSString';
    if (nonNull.isDartCoreInt ||
        nonNull.isDartCoreDouble ||
        nonNull.isDartCoreNum) {
      return 'JSNumber';
    }
    if (nonNull.isDartCoreBool) return 'JSBoolean';
    if (_isJsInteropExtensionType(nonNull)) return typeToCode(nonNull);
    if (_isJsCodableClass(nonNull)) return '${nonNull.element!.name!}JS';
    if (coreMapTypeChecker.isAssignableFromType(nonNull)) return 'JSObject';
    if (coreIterableTypeChecker.isAssignableFromType(nonNull)) {
      return 'JSArray<JSAny?>';
    }
    return 'JSAny?';
  }

  String _enumExternalBaseType(DartType enumType) {
    final encodedValues = enumEncodedValues(enumType) ?? const [];
    final nonNullValues = encodedValues.nonNulls.toList();
    if (nonNullValues.every((v) => v is String)) {
      return 'String';
    }
    if (nonNullValues.every((v) => v is int)) {
      return 'int';
    }
    return 'JSAny';
  }

  Expression _deserializeForField(
    FieldElement field, {
    FormalParameterElement? ctorParam,
  }) {
    final targetType = _decodeTargetTypeForField(field, ctorParam: ctorParam);
    final jsonKey = jsonKeyFor(field);
    final defaultValue = jsonKey.defaultValue;
    final ctx = getHelperContext(field);
    final jsProp = refer('js').property(field.name!);

    try {
      final fromJsonData = ctx.deserializeConvertData;
      if (fromJsonData != null) {
        _validatePublicExecutableName(field, 'fromJson', fromJsonData.name);
        return _deserializeWithCustomFunction(
          targetType: targetType,
          wireType: fromJsonData.paramType,
          returnType: fromJsonData.returnType,
          functionName: fromJsonData.name,
          jsProp: jsProp,
          defaultValue: defaultValue,
        );
      }

      final converter = typeConverter(targetType, ctx);
      if (converter != null) {
        _validatePublicConverterAccess(field, converter.accessString);
        return _deserializeWithCustomFunction(
          targetType: targetType,
          wireType: converter.jsonType,
          returnType: converter.fieldType,
          functionName: '${converter.accessString}.fromJson',
          jsProp: jsProp,
          defaultValue: defaultValue,
        );
      }

      return _deserializeExternalValue(
        targetType: targetType,
        jsExpr: jsProp,
        ctx: ctx,
        defaultValue: defaultValue,
      );
    } on UnsupportedTypeError catch (e) // ignore: avoid_catching_errors
    {
      throw createInvalidGenerationError('fromJson', field, e);
    }
  }

  Expression _deserializeWithCustomFunction({
    required DartType targetType,
    required DartType wireType,
    required DartType returnType,
    required String functionName,
    required Expression jsProp,
    required String? defaultValue,
  }) {
    final isGetterNullable =
        targetType.isNullableType ||
        defaultValue != null ||
        wireType.isNullableType;

    Expression invokeOnNonNull(Expression nonNullJsExpr) {
      final bridged = _bridgeJsExternalToConverterWire(
        nonNullJsExpr,
        wireType.promoteNonNullable(),
      );
      final callExpr = refer(functionName).call([bridged]);
      if (defaultValue != null &&
          !targetType.isNullableType &&
          returnType.isNullableType) {
        return callExpr.ifNullThen(
          CodeExpression(Code(DefaultContainer.wrapDefaultValue(defaultValue))),
        );
      }
      return callExpr;
    }

    if (!isGetterNullable) {
      return invokeOnNonNull(jsProp);
    }

    if (wireType.isNullableType &&
        defaultValue == null &&
        (!targetType.isNullableType || returnType.isNullableType)) {
      final nonNullWire = wireType.promoteNonNullable();
      if (_isPrimitiveJsExternalType(nonNullWire) ||
          _isJsInteropExtensionType(nonNullWire)) {
        return refer(functionName).call([jsProp]);
      }
      if (_isDynamicOrObject(nonNullWire)) {
        return refer(
          functionName,
        ).call([jsProp.nullSafeProperty('dartify').call([])]);
      }
      return _nullSwitchExpression(
        jsProp,
        onNonNull: invokeOnNonNull,
        defaultValue: toCodeString(refer(functionName).call([literalNull])),
      );
    }

    return _nullSwitchExpression(
      jsProp,
      onNonNull: invokeOnNonNull,
      defaultValue: defaultValue,
    );
  }

  Expression _bridgeJsExternalToConverterWire(
    Expression nonNullJsExpr,
    DartType nonNullWireType,
  ) {
    if (_isPrimitiveJsExternalType(nonNullWireType) ||
        _isJsInteropExtensionType(nonNullWireType)) {
      return nonNullJsExpr;
    }
    if (_isJsCodableClass(nonNullWireType)) {
      return refer(
        '\$${nonNullWireType.element!.name!}FromJs',
      ).call([nonNullJsExpr]);
    }
    final dartified = nonNullJsExpr.property('dartify').call([]);
    if (coreMapTypeChecker.isAssignableFromType(nonNullWireType)) {
      final typeArgs = nonNullWireType.typeArgumentsOf(coreMapTypeChecker)!;
      final kType = typeArgs[0];
      final vType = typeArgs[1];
      final asMap = dartified.asA(refer('Map'));
      if (_isDynamicOrObject(kType) && _isDynamicOrObject(vType)) {
        return asMap;
      }
      return asMap.property('cast').call([], {}, [
        refer(typeToCode(kType)),
        refer(typeToCode(vType)),
      ]);
    }
    if (coreIterableTypeChecker.isAssignableFromType(nonNullWireType)) {
      final itemType = coreIterableGenericType(nonNullWireType);
      final asList = dartified.asA(refer('List'));
      final casted = _isDynamicOrObject(itemType)
          ? asList
          : asList.property('cast').call([], {}, [refer(typeToCode(itemType))]);
      return _coreSetChecker.isAssignableFromType(nonNullWireType)
          ? casted.property('toSet').call([])
          : casted;
    }
    if (nonNullWireType.isDartCoreObject) {
      return dartified.nullChecked;
    }
    return dartified;
  }

  Expression _deserializeExternalValue({
    required DartType targetType,
    required Expression jsExpr,
    required TypeHelperCtx ctx,
    required String? defaultValue,
  }) {
    final nonNull = targetType.promoteNonNullable();
    final isGetterNullable =
        targetType.isNullableType ||
        defaultValue != null ||
        enumFieldWithNullInEncodeMap(targetType) == true;

    // 1. Primitives & direct JS interop extension types: 0 casts, no switch.
    if (_isPrimitiveJsExternalType(nonNull) ||
        _isJsInteropExtensionType(nonNull)) {
      if (defaultValue != null) {
        return jsExpr.ifNullThen(
          CodeExpression(Code(DefaultContainer.wrapDefaultValue(defaultValue))),
        );
      }
      return jsExpr;
    }

    // 2. Object? / dynamic
    if (_isDynamicOrObject(nonNull)) {
      final dartified = jsExpr.property('dartify').call([]);
      if (defaultValue != null) {
        return dartified.ifNullThen(
          CodeExpression(Code(DefaultContainer.wrapDefaultValue(defaultValue))),
        );
      }
      if (targetType.isDartCoreObject && !targetType.isNullableType) {
        return dartified.nullChecked;
      }
      return dartified;
    }

    // 3. Enums
    if (nonNull.isEnum) {
      return _deserializeEnum(
        targetType: targetType,
        wireExpr: jsExpr,
        ctx: ctx,
        defaultValue: defaultValue,
      );
    }

    // 4. Types that convert a non-null external wire value (DateTime, Uri,
    //    BigInt, Duration, nested @JsonSerializable, Iterable, Map).
    if (isGetterNullable) {
      return _nullSwitchExpression(
        jsExpr,
        onNonNull: (v) =>
            _convertNonNullExternalValue(targetType, nonNull, v, ctx),
        defaultValue: defaultValue,
      );
    }

    return _convertNonNullExternalValue(targetType, nonNull, jsExpr, ctx);
  }

  Expression _convertNonNullExternalValue(
    DartType targetType,
    DartType nonNull,
    Expression nonNullWire,
    TypeHelperCtx ctx,
  ) {
    if (coreDateTimeTypeChecker.isExactlyType(nonNull)) {
      return dateTimeString
          .deserialize(nonNull, nonNullWire, false, true)!
          .output;
    }
    if (coreUriTypeChecker.isExactlyType(nonNull)) {
      return uriString.deserialize(nonNull, nonNullWire, false, true)!.output;
    }
    if (coreBigIntTypeChecker.isExactlyType(nonNull)) {
      return bigIntString
          .deserialize(nonNull, nonNullWire, false, true)!
          .output;
    }
    if (_coreDurationChecker.isExactlyType(nonNull)) {
      return refer('Duration').newInstance([], {'microseconds': nonNullWire});
    }
    if (_isJsCodableClass(nonNull)) {
      return LambdaResult(nonNullWire, '\$${nonNull.element!.name!}FromJs');
    }
    if (coreIterableTypeChecker.isAssignableFromType(nonNull)) {
      return _deserializeIterableFromJsArray(nonNull, nonNullWire, ctx);
    }
    if (coreMapTypeChecker.isAssignableFromType(nonNull)) {
      return _deserializeMapFromJsObject(nonNull, nonNullWire, ctx);
    }
    throw UnsupportedTypeError(targetType, toCodeString(nonNullWire));
  }

  Expression _deserializeEnum({
    required DartType targetType,
    required Expression wireExpr,
    required TypeHelperCtx ctx,
    required String? defaultValue,
  }) {
    final memberContent = enumValueMapFromType(targetType);
    if (memberContent == null) {
      throw UnsupportedTypeError(targetType, toCodeString(wireExpr));
    }
    addMember(memberContent);
    _packageImports.add('package:json_annotation/json_annotation.dart');

    final jsonKey = jsonKeyForField(ctx.fieldElement, ctx.config);
    final unknownEnumValue = jsonKey.unknownEnumValue;

    if (!targetType.isNullableType &&
        unknownEnumValue == jsonKeyNullForUndefinedEnumValueFieldName) {
      throw InvalidGenerationSourceError(
        '`$jsonKeyNullForUndefinedEnumValueFieldName` cannot be used with '
        '`JsonKey.unknownEnumValue` unless the field is nullable.',
        element: ctx.fieldElement,
      );
    }

    final nullEnumValue = enumValueForNull(targetType);
    final useNullableDecode =
        targetType.isNullableType ||
        defaultValue != null ||
        nullEnumValue != null;
    final functionName = useNullableDecode
        ? r'$enumDecodeNullable'
        : r'$enumDecode';

    final namedArgs = <String, Expression>{
      if (unknownEnumValue != null)
        'unknownValue': CodeExpression(Code(unknownEnumValue)),
    };

    final decoded = refer(
      functionName,
    ).call([refer(constMapName(targetType)), wireExpr], namedArgs);

    if (defaultValue != null) {
      return decoded.ifNullThen(
        CodeExpression(Code(DefaultContainer.wrapDefaultValue(defaultValue))),
      );
    }
    if (!targetType.isNullableType && nullEnumValue != null) {
      return decoded.ifNullThen(refer(nullEnumValue));
    }
    return decoded;
  }

  Expression _deserializeIterableFromJsArray(
    DartType nonNullIterableType,
    Expression jsArrayExpr,
    TypeHelperCtx ctx,
  ) {
    final itemType = coreIterableGenericType(nonNullIterableType);
    final isSet = _coreSetChecker.isAssignableFromType(nonNullIterableType);
    final toCollectionMethod = isSet ? 'toSet' : 'toList';

    final elemDecoded = _deserializeFromBoxedJs(
      itemType,
      refer(closureArg),
      ctx,
    );
    final elemDecodedStr = toCodeString(elemDecoded);
    final toDartList = jsArrayExpr.property('toDart');

    if (elemDecodedStr == closureArg) {
      return isSet ? toDartList.property('toSet').call([]) : toDartList;
    }

    final mapper = LambdaResult.process(elemDecoded);
    return toDartList
        .property('map')
        .call([mapper])
        .property(toCollectionMethod)
        .call([]);
  }

  Expression _deserializeMapFromJsObject(
    DartType nonNullMapType,
    Expression jsObjExpr,
    TypeHelperCtx ctx,
  ) {
    final typeArgs = nonNullMapType.typeArgumentsOf(coreMapTypeChecker)!;
    final keyType = typeArgs[0];
    final valueType = typeArgs[1];

    _dartImports.add('dart:js_interop_unsafe');
    addMember(_jsObjectKeysHelperDeclaration);

    Expression buildComprehension(Expression boundObj) {
      final jsKeyRef = refer('k');
      final keyDartString = jsKeyRef.property('toDart');
      final decodedKey = _deserializeMapKey(keyType, keyDartString, ctx);

      final Expression decodedValue;
      if (_isDynamicOrObject(valueType)) {
        final rawProp = boundObj
            .property('getProperty')
            .call([jsKeyRef], {}, [refer('JSAny?')]);
        final dartified = rawProp.property('dartify').call([]);
        decodedValue = valueType.isDartCoreObject && !valueType.isNullableType
            ? dartified.nullChecked
            : dartified;
      } else {
        final boxedValType = _jsBoxedType(valueType, ctx);
        final propExpr = boundObj
            .property('getProperty')
            .call([jsKeyRef], {}, [refer(boxedValType)]);
        decodedValue = _deserializeFromBoxedJs(valueType, propExpr, ctx);
      }

      return CodeExpression(
        Code(
          '{for (final k in _\$jsObjectKeys(${toCodeString(boundObj)}).toDart) '
          '${toCodeString(decodedKey)}: ${toCodeString(decodedValue)}}',
        ),
      );
    }

    final objStr = toCodeString(jsObjExpr).trim();
    if (_simpleDartIdentifier.hasMatch(objStr)) {
      return buildComprehension(jsObjExpr);
    }

    return CodeExpression(
      Code(
        'switch (${toCodeString(jsObjExpr)}) { '
        'final m => ${toCodeString(buildComprehension(refer('m')))} '
        '}',
      ),
    );
  }

  Expression _deserializeMapKey(
    DartType keyType,
    Expression keyStringExpr,
    TypeHelperCtx ctx,
  ) {
    final nonNull = keyType.promoteNonNullable();
    if (nonNull.isDartCoreString || _isDynamicOrObject(nonNull)) {
      return keyStringExpr;
    }
    if (typeConverter(keyType, ctx) case final converter?) {
      _validatePublicConverterAccess(ctx.fieldElement, converter.accessString);
      return refer('${converter.accessString}.fromJson').call([keyStringExpr]);
    }
    if (nonNull.isEnum) {
      final encodedValues = enumEncodedValues(nonNull);
      var keyArg = keyStringExpr;
      if (encodedValues != null &&
          encodedValues.every((v) => v is int || v == null)) {
        keyArg = refer('int.parse').call([keyStringExpr]);
      }
      return _deserializeEnum(
        targetType: nonNull,
        wireExpr: keyArg,
        ctx: ctx,
        defaultValue: null,
      );
    }
    if (nonNull.isDartCoreInt) {
      return refer('int.parse').call([keyStringExpr]);
    }
    if (coreBigIntTypeChecker.isExactlyType(nonNull)) {
      return refer('BigInt.parse').call([keyStringExpr]);
    }
    if (coreUriTypeChecker.isExactlyType(nonNull)) {
      return refer('Uri.parse').call([keyStringExpr]);
    }
    if (coreDateTimeTypeChecker.isExactlyType(nonNull)) {
      return refer('DateTime.parse').call([keyStringExpr]);
    }
    throw UnsupportedTypeError(keyType, toCodeString(keyStringExpr));
  }

  Expression _deserializeFromBoxedJs(
    DartType targetType,
    Expression boxedExpr,
    TypeHelperCtx ctx,
  ) {
    final nonNull = targetType.promoteNonNullable();
    final isNullable = targetType.isNullableType;

    if (typeConverter(targetType, ctx) case final converter?) {
      _validatePublicConverterAccess(ctx.fieldElement, converter.accessString);
      final wireType = converter.jsonType;
      final nonNullWire = wireType.promoteNonNullable();
      Expression convertBoxedNonNull(Expression nonNullBoxed) {
        final wireExpr = _unboxJsAnyToConverterWire(nonNullBoxed, nonNullWire);
        return refer('${converter.accessString}.fromJson').call([wireExpr]);
      }

      if (wireType.isNullableType &&
          (!isNullable || converter.fieldType.isNullableType)) {
        if (_isJsInteropExtensionType(nonNullWire)) {
          return refer('${converter.accessString}.fromJson').call([boxedExpr]);
        }
        if (_boxedPrimitiveGetterName(nonNullWire) case final getterName?) {
          return refer(
            '${converter.accessString}.fromJson',
          ).call([boxedExpr.nullSafeProperty(getterName)]);
        }
        if (_isDynamicOrObject(nonNullWire)) {
          return refer(
            '${converter.accessString}.fromJson',
          ).call([boxedExpr.nullSafeProperty('dartify').call([])]);
        }
        return _nullSwitchExpression(
          boxedExpr,
          onNonNull: convertBoxedNonNull,
          defaultValue: toCodeString(
            refer('${converter.accessString}.fromJson').call([literalNull]),
          ),
        );
      }

      if (isNullable) {
        return _nullSwitchExpression(
          boxedExpr,
          onNonNull: convertBoxedNonNull,
          defaultValue: null,
        );
      }
      return convertBoxedNonNull(boxedExpr);
    }

    if (_boxedPrimitiveGetterName(nonNull) case final getterName?) {
      return isNullable
          ? boxedExpr.nullSafeProperty(getterName)
          : boxedExpr.property(getterName);
    }
    if (_isJsInteropExtensionType(nonNull)) {
      return boxedExpr;
    }
    if (_isDynamicOrObject(nonNull)) {
      final dartified = boxedExpr.property('dartify').call([]);
      return targetType.isDartCoreObject && !isNullable
          ? dartified.nullChecked
          : dartified;
    }

    if (isNullable) {
      return _nullSwitchExpression(
        boxedExpr,
        onNonNull: (v) =>
            _convertNonNullBoxedValue(targetType, nonNull, v, ctx),
        defaultValue: null,
      );
    }

    return _convertNonNullBoxedValue(targetType, nonNull, boxedExpr, ctx);
  }

  String? _boxedPrimitiveGetterName(DartType nonNull) {
    if (nonNull.isDartCoreString || nonNull.isDartCoreBool) return 'toDart';
    if (nonNull.isDartCoreInt) return 'toDartInt';
    if (nonNull.isDartCoreDouble || nonNull.isDartCoreNum) {
      return 'toDartDouble';
    }
    return null;
  }

  Expression _convertNonNullBoxedValue(
    DartType targetType,
    DartType nonNull,
    Expression nonNullBoxed,
    TypeHelperCtx ctx,
  ) {
    if (coreDateTimeTypeChecker.isExactlyType(nonNull)) {
      return refer('DateTime.parse').call([nonNullBoxed.property('toDart')]);
    }
    if (coreUriTypeChecker.isExactlyType(nonNull)) {
      return refer('Uri.parse').call([nonNullBoxed.property('toDart')]);
    }
    if (coreBigIntTypeChecker.isExactlyType(nonNull)) {
      return refer('BigInt.parse').call([nonNullBoxed.property('toDart')]);
    }
    if (_coreDurationChecker.isExactlyType(nonNull)) {
      return refer(
        'Duration',
      ).newInstance([], {'microseconds': nonNullBoxed.property('toDartInt')});
    }
    if (nonNull.isEnum) {
      final enumBase = _enumExternalBaseType(nonNull);
      final unboxed = switch (enumBase) {
        'String' => nonNullBoxed.property('toDart'),
        'int' => nonNullBoxed.property('toDartInt'),
        _ => nonNullBoxed.property('dartify').call([]),
      };
      return _deserializeEnum(
        targetType: targetType,
        wireExpr: unboxed,
        ctx: ctx,
        defaultValue: null,
      );
    }
    if (_isJsCodableClass(nonNull)) {
      return LambdaResult(nonNullBoxed, '\$${nonNull.element!.name!}FromJs');
    }
    if (coreIterableTypeChecker.isAssignableFromType(nonNull)) {
      return _deserializeIterableFromJsArray(nonNull, nonNullBoxed, ctx);
    }
    if (coreMapTypeChecker.isAssignableFromType(nonNull)) {
      return _deserializeMapFromJsObject(nonNull, nonNullBoxed, ctx);
    }
    throw UnsupportedTypeError(targetType, toCodeString(nonNullBoxed));
  }

  Expression _unboxJsAnyToConverterWire(
    Expression nonNullBoxed,
    DartType nonNullWireType,
  ) {
    if (_boxedPrimitiveGetterName(nonNullWireType) case final getterName?) {
      return nonNullBoxed.property(getterName);
    }
    return _bridgeJsExternalToConverterWire(nonNullBoxed, nonNullWireType);
  }

  Expression _serializeForField(FieldElement field, Expression accessExpr) {
    final targetType = field.type;
    final ctx = getHelperContext(field);

    try {
      final toJsonData = ctx.serializeConvertData;
      if (toJsonData != null) {
        _validatePublicExecutableName(field, 'toJson', toJsonData.name);
        return _serializeWithCustomFunction(
          targetType: targetType,
          paramType: toJsonData.paramType,
          wireType: toJsonData.returnType,
          functionName: toJsonData.name,
          accessExpr: accessExpr,
        );
      }

      final converter = typeConverter(targetType, ctx);
      if (converter != null) {
        _validatePublicConverterAccess(field, converter.accessString);
        return _serializeWithCustomFunction(
          targetType: targetType,
          paramType: converter.fieldType,
          wireType: converter.jsonType,
          functionName: '${converter.accessString}.toJson',
          accessExpr: accessExpr,
        );
      }

      return _serializeToExternalJs(
        targetType: targetType,
        dartExpr: accessExpr,
        ctx: ctx,
      );
    } on UnsupportedTypeError catch (e) // ignore: avoid_catching_errors
    {
      throw createInvalidGenerationError('toJson', field, e);
    }
  }

  Expression _serializeWithCustomFunction({
    required DartType targetType,
    required DartType paramType,
    required DartType wireType,
    required String functionName,
    required Expression accessExpr,
  }) {
    Expression invokeAndBridge(Expression argExpr) {
      final callExpr = refer(functionName).call([argExpr]);
      return _bridgeConverterWireToJsExternal(callExpr, wireType);
    }

    if (targetType.isNullableType && !paramType.isNullableType) {
      return _nullSwitchExpression(
        accessExpr,
        onNonNull: invokeAndBridge,
        defaultValue: null,
      );
    }

    return invokeAndBridge(accessExpr);
  }

  Expression _bridgeConverterWireToJsExternal(
    Expression wireExpr,
    DartType wireType,
  ) {
    final nonNull = wireType.promoteNonNullable();
    final isNullable = wireType.isNullableType;

    if (_isPrimitiveJsExternalType(nonNull) ||
        _isJsInteropExtensionType(nonNull)) {
      return wireExpr;
    }
    if (_isJsCodableClass(nonNull)) {
      final toJsFn = '\$${nonNull.element!.name!}ToJs';
      if (isNullable) {
        return _nullSwitchExpression(
          wireExpr,
          onNonNull: (v) => refer(toJsFn).call([v]),
          defaultValue: null,
        );
      }
      return refer(toJsFn).call([wireExpr]);
    }
    if (coreMapTypeChecker.isAssignableFromType(nonNull) ||
        coreIterableTypeChecker.isAssignableFromType(nonNull)) {
      final baseJsType = coreMapTypeChecker.isAssignableFromType(nonNull)
          ? 'JSObject'
          : 'JSArray<JSAny?>';
      final jsified = isNullable
          ? wireExpr.nullSafeProperty('jsify').call([])
          : wireExpr.property('jsify').call([]);
      return jsified.asA(refer(_withNullability(baseJsType, isNullable)));
    }
    if (!isNullable && nonNull.isDartCoreObject) {
      return wireExpr.property('jsify').call([]).nullChecked;
    }
    final receiver = wireType is DynamicType
        ? wireExpr.asA(refer('Object?'))
        : wireExpr;
    return receiver.property('jsify').call([]);
  }

  Expression _serializeToExternalJs({
    required DartType targetType,
    required Expression dartExpr,
    required TypeHelperCtx ctx,
  }) {
    final nonNull = targetType.promoteNonNullable();
    final isNullable = targetType.isNullableType;

    if (_isPrimitiveJsExternalType(nonNull) ||
        _isJsInteropExtensionType(nonNull)) {
      return dartExpr;
    }

    if (_isDynamicOrObject(nonNull)) {
      final receiver = targetType is DynamicType
          ? dartExpr.asA(refer('Object?'))
          : dartExpr;
      final jsified = receiver.property('jsify').call([]);
      return targetType.isDartCoreObject && !isNullable
          ? jsified.nullChecked
          : jsified;
    }

    if (_serializeCoreValueToPrimitive(
          targetType,
          nonNull,
          dartExpr,
          isNullable: isNullable,
        )
        case final corePrimitive?) {
      return corePrimitive;
    }

    if (nonNull.isEnum) {
      return _serializeEnum(targetType, dartExpr);
    }

    return _serializeCompositeToJs(
      targetType,
      nonNull,
      dartExpr,
      ctx,
      isNullable: isNullable,
    );
  }

  Expression? _serializeCoreValueToPrimitive(
    DartType targetType,
    DartType nonNull,
    Expression dartExpr, {
    required bool isNullable,
  }) {
    if (coreDateTimeTypeChecker.isExactlyType(nonNull)) {
      final helper = config.dateTimeUtc ? dateTimeUtcString : dateTimeString;
      return helper.serialize(targetType, dartExpr, isNullable)!;
    }
    if (coreUriTypeChecker.isExactlyType(nonNull)) {
      return uriString.serialize(targetType, dartExpr, isNullable)!;
    }
    if (coreBigIntTypeChecker.isExactlyType(nonNull)) {
      return bigIntString.serialize(targetType, dartExpr, isNullable)!;
    }
    if (_coreDurationChecker.isExactlyType(nonNull)) {
      return isNullable
          ? dartExpr.nullSafeProperty('inMicroseconds')
          : dartExpr.property('inMicroseconds');
    }
    return null;
  }

  Expression _serializeCompositeToJs(
    DartType targetType,
    DartType nonNull,
    Expression dartExpr,
    TypeHelperCtx ctx, {
    required bool isNullable,
  }) {
    if (_isJsCodableClass(nonNull)) {
      final toJsFn = '\$${nonNull.element!.name!}ToJs';
      if (isNullable) {
        return _nullSwitchExpression(
          dartExpr,
          onNonNull: (v) => refer(toJsFn).call([v]),
          defaultValue: null,
        );
      }
      return LambdaResult(dartExpr, toJsFn);
    }

    if (coreIterableTypeChecker.isAssignableFromType(nonNull)) {
      return _serializeIterableToJsArray(targetType, dartExpr, ctx);
    }

    if (coreMapTypeChecker.isAssignableFromType(nonNull)) {
      if (isNullable) {
        return _nullSwitchExpression(
          dartExpr,
          onNonNull: (v) => _serializeMapToJsObject(nonNull, v, ctx),
          defaultValue: null,
        );
      }
      return _serializeMapToJsObject(nonNull, dartExpr, ctx);
    }

    throw UnsupportedTypeError(targetType, toCodeString(dartExpr));
  }

  Expression _serializeEnum(DartType targetType, Expression dartExpr) {
    final memberContent = enumValueMapFromType(targetType);
    if (memberContent == null) {
      throw UnsupportedTypeError(targetType, toCodeString(dartExpr));
    }
    addMember(memberContent);

    final mapLookup = refer(constMapName(targetType)).index(dartExpr);
    if (targetType.isNullableType ||
        enumFieldWithNullInEncodeMap(targetType) == true) {
      return mapLookup;
    }
    return mapLookup.nullChecked;
  }

  Expression _serializeIterableToJsArray(
    DartType targetType,
    Expression dartIterExpr,
    TypeHelperCtx ctx,
  ) {
    final nonNull = targetType.promoteNonNullable();
    final isNullable = targetType.isNullableType;
    final itemType = coreIterableGenericType(nonNull);
    final isList = _coreListChecker.isAssignableFromType(nonNull);

    final elemEncoded = _serializeToBoxedJs(itemType, refer(closureArg), ctx);
    final elemEncodedStr = toCodeString(elemEncoded);

    if (elemEncodedStr == closureArg) {
      if (isList) {
        return isNullable
            ? dartIterExpr.nullSafeProperty('toJS')
            : dartIterExpr.property('toJS');
      }
      final toListExpr = isNullable
          ? dartIterExpr.nullSafeProperty('toList').call([])
          : dartIterExpr.property('toList').call([]);
      return toListExpr.property('toJS');
    }

    final mapper = LambdaResult.process(elemEncoded);
    final mapped = isNullable
        ? dartIterExpr.nullSafeProperty('map').call([mapper])
        : dartIterExpr.property('map').call([mapper]);
    return mapped.property('toList').call([]).property('toJS');
  }

  Expression _serializeMapToJsObject(
    DartType nonNullMapType,
    Expression dartMapExpr,
    TypeHelperCtx ctx,
  ) {
    final typeArgs = nonNullMapType.typeArgumentsOf(coreMapTypeChecker)!;
    final keyType = typeArgs[0];
    final valueType = typeArgs[1];

    _dartImports.add('dart:js_interop_unsafe');

    final encodedKeyJs = _serializeMapKeyToJsString(keyType, refer('key'), ctx);
    final encodedValJs = _serializeToBoxedJs(valueType, refer('value'), ctx);

    final mapCode = toCodeString(dartMapExpr);
    final keyCode = toCodeString(encodedKeyJs);
    final valCode = toCodeString(encodedValJs);

    return CodeExpression(
      Code(
        '(() {\n'
        '  final \$map = JSObject();\n'
        '  for (final MapEntry(:key, :value) in $mapCode.entries) {\n'
        '    \$map.setProperty($keyCode, $valCode);\n'
        '  }\n'
        '  return \$map;\n'
        '})()',
      ),
    );
  }

  Expression _serializeMapKeyToJsString(
    DartType keyType,
    Expression keyExpr,
    TypeHelperCtx ctx,
  ) {
    final nonNull = keyType.promoteNonNullable();
    if (nonNull.isDartCoreString) {
      return keyExpr.property('toJS');
    }
    if (typeConverter(keyType, ctx) case final converter?) {
      _validatePublicConverterAccess(ctx.fieldElement, converter.accessString);
      return refer(
        '${converter.accessString}.toJson',
      ).call([keyExpr]).property('toJS');
    }
    if (nonNull.isEnum) {
      final enumEncoded = _serializeEnum(nonNull, keyExpr);
      final enumBase = _enumExternalBaseType(nonNull);
      return enumBase == 'String'
          ? enumEncoded.property('toJS')
          : enumEncoded.property('toString').call([]).property('toJS');
    }
    if (coreDateTimeTypeChecker.isExactlyType(nonNull)) {
      final helper = config.dateTimeUtc ? dateTimeUtcString : dateTimeString;
      return helper.serialize(nonNull, keyExpr, false)!.property('toJS');
    }
    if (nonNull.isDartCoreInt ||
        coreBigIntTypeChecker.isExactlyType(nonNull) ||
        coreUriTypeChecker.isExactlyType(nonNull) ||
        _isDynamicOrObject(nonNull)) {
      return keyExpr.property('toString').call([]).property('toJS');
    }
    throw UnsupportedTypeError(keyType, toCodeString(keyExpr));
  }

  Expression _serializeToBoxedJs(
    DartType targetType,
    Expression dartExpr,
    TypeHelperCtx ctx,
  ) {
    final nonNull = targetType.promoteNonNullable();
    final isNullable = targetType.isNullableType;

    if (typeConverter(targetType, ctx) case final converter?) {
      _validatePublicConverterAccess(ctx.fieldElement, converter.accessString);
      Expression encodeNonNull(Expression nonNullDart) {
        final wireExpr = refer(
          '${converter.accessString}.toJson',
        ).call([nonNullDart]);
        return _boxConverterWireToJsAny(wireExpr, converter.jsonType);
      }

      if (isNullable && !converter.fieldType.isNullableType) {
        return _nullSwitchExpression(
          dartExpr,
          onNonNull: encodeNonNull,
          defaultValue: null,
        );
      }
      return encodeNonNull(dartExpr);
    }

    if (_isPrimitiveJsExternalType(nonNull)) {
      return isNullable
          ? dartExpr.nullSafeProperty('toJS')
          : dartExpr.property('toJS');
    }
    if (_isJsInteropExtensionType(nonNull)) {
      return dartExpr;
    }
    if (_isDynamicOrObject(nonNull)) {
      final receiver = targetType is DynamicType
          ? dartExpr.asA(refer('Object?'))
          : dartExpr;
      return receiver.property('jsify').call([]);
    }

    if (_serializeCoreValueToPrimitive(
          targetType,
          nonNull,
          dartExpr,
          isNullable: isNullable,
        )
        case final corePrimitive?) {
      return corePrimitive.property('toJS');
    }
    if (nonNull.isEnum) {
      final enumVal = _serializeEnum(targetType, dartExpr);
      final isEnumNullable =
          isNullable || enumFieldWithNullInEncodeMap(targetType) == true;
      return isEnumNullable
          ? enumVal.nullSafeProperty('toJS')
          : enumVal.property('toJS');
    }

    return _serializeCompositeToJs(
      targetType,
      nonNull,
      dartExpr,
      ctx,
      isNullable: isNullable,
    );
  }

  Expression _boxConverterWireToJsAny(Expression wireExpr, DartType wireType) {
    final nonNull = wireType.promoteNonNullable();
    final isNullable = wireType.isNullableType;
    if (_isPrimitiveJsExternalType(nonNull)) {
      return isNullable
          ? wireExpr.nullSafeProperty('toJS')
          : wireExpr.property('toJS');
    }
    return _bridgeConverterWireToJsExternal(wireExpr, wireType);
  }

  Expression _nullSwitchExpression(
    Expression subject, {
    required Expression Function(Expression nonNullVar) onNonNull,
    required String? defaultValue,
  }) {
    final subjectCode = toCodeString(subject);
    final nonNullBody = toCodeString(onNonNull(refer('v')));
    final nullBranch = defaultValue ?? 'null';
    return CodeExpression(
      Code(
        'switch ($subjectCode) {\n'
        '  final v? => $nonNullBody,\n'
        '  null => $nullBranch,\n'
        '}',
      ),
    );
  }

  void _validatePublicExecutableName(
    FieldElement field,
    String paramName,
    String qualifiedName,
  ) {
    if (qualifiedName.split('.').any((part) => part.startsWith('_'))) {
      throw InvalidGenerationSourceError(
        'The `$paramName` function `$qualifiedName` on `${field.name}` is '
        'private and cannot be accessed from the standalone '
        '`.js_codable.dart` library.',
        element: field,
      );
    }
  }

  void _validatePublicConverterAccess(FieldElement field, String accessString) {
    final stripped = accessString
        .replaceFirst(RegExp(r'^const\s+'), '')
        .replaceFirst(RegExp(r'\(\)$'), '')
        .replaceAll(RegExp(r'<.*>'), '');
    if (stripped.split('.').any((part) => part.startsWith('_'))) {
      throw InvalidGenerationSourceError(
        'The `JsonConverter` `$accessString` on `${field.name}` is private '
        'and cannot be accessed from the standalone `.js_codable.dart` '
        'library.',
        element: field,
      );
    }
  }

  void _collectFieldImports(FieldElement field) {
    final decodeType = _decodeTargetTypeForField(field);
    for (final type in {decodeType, field.type}) {
      _collectTypeImports(type);
      final ctx = getHelperContext(field);
      if (typeConverter(type, ctx) case final converter?) {
        _collectTypeImports(converter.jsonType);
        _collectTypeImports(converter.fieldType);
      }
    }

    final ctx = getHelperContext(field);
    for (final convertData in [
      ?ctx.deserializeConvertData,
      ?ctx.serializeConvertData,
    ]) {
      _collectTypeImports(convertData.paramType);
      _collectTypeImports(convertData.returnType);
    }

    for (final f in fieldHierarchyFor(field)) {
      for (final ann in [
        ...f.metadata.annotations,
        ...?f.getter?.metadata.annotations,
      ]) {
        _collectTypeImports(ann.computeConstantValue()?.type);
      }
      final keyAnn = jsonKeyAnnotation(f);
      if (!keyAnn.isNull) {
        _recordLibraryImport(
          keyAnn.peek('fromJson')?.objectValue.toFunctionValue()?.library,
        );
        _recordLibraryImport(
          keyAnn.peek('toJson')?.objectValue.toFunctionValue()?.library,
        );
      }
    }
  }

  void _collectTypeImports(DartType? type) {
    if (type == null) return;
    if (type.alias case final alias?) {
      _recordLibraryImport(alias.element.library);
      for (final arg in alias.typeArguments) {
        _collectTypeImports(arg);
      }
    }
    if (type is InterfaceType) {
      final lib = type.element.library;
      _recordLibraryImport(lib);
      if (_isJsCodableClass(type) && lib != element.library) {
        _recordJsCodableCompanionImport(lib);
      }
      for (final arg in type.typeArguments) {
        _collectTypeImports(arg);
      }
    } else if (type is RecordType) {
      for (final f in type.positionalFields) {
        _collectTypeImports(f.type);
      }
      for (final f in type.namedFields) {
        _collectTypeImports(f.type);
      }
    }
  }

  void _recordLibraryImport(LibraryElement? targetLib) {
    if (targetLib == null || targetLib.isDartCore) return;
    final uriStr = _importUriFor(targetLib);
    if (uriStr == null) return;
    _categorizeImport(uriStr);
  }

  void _recordJsCodableCompanionImport(LibraryElement targetLib) {
    final uriStr = _importUriFor(targetLib);
    if (uriStr == null || !uriStr.endsWith('.dart')) return;
    final stem = uriStr.substring(0, uriStr.length - '.dart'.length);
    _categorizeImport('$stem.js_codable.dart');
  }

  void _categorizeImport(String uriStr) {
    if (uriStr.startsWith('dart:')) {
      _dartImports.add(uriStr);
    } else if (uriStr.startsWith('package:')) {
      if (uriStr == 'package:json_annotation/json_annotation.dart' ||
          uriStr.startsWith('package:json_annotation/src/')) {
        // Only imported on-demand when $enumDecode / $enumDecodeNullable is used.
        return;
      }
      _packageImports.add(uriStr);
    } else {
      _relativeImports.add(uriStr);
    }
  }

  String? _importUriFor(LibraryElement targetLib) {
    final sourceUri = element.library.uri;
    final targetUri = targetLib.uri;

    if (targetUri.scheme == 'dart') {
      return targetUri.toString();
    }

    if (targetLib == element.library) {
      return p.posix.basename(sourceUri.path);
    }

    if (targetUri.scheme == sourceUri.scheme &&
        targetUri.pathSegments.isNotEmpty &&
        sourceUri.pathSegments.isNotEmpty &&
        targetUri.pathSegments.first == sourceUri.pathSegments.first) {
      return p.posix.relative(
        targetUri.path,
        from: p.posix.dirname(sourceUri.path),
      );
    }

    if (targetUri.scheme == 'package') {
      return targetUri.toString();
    }

    if (targetUri.scheme == 'asset' &&
        targetUri.pathSegments.length > 2 &&
        targetUri.pathSegments[1] == 'lib') {
      final pkg = targetUri.pathSegments.first;
      final rest = targetUri.pathSegments.skip(2).join('/');
      return 'package:$pkg/$rest';
    }

    return p.posix.basename(targetUri.path);
  }
}

bool _isPrimitiveJsExternalType(DartType nonNullType) =>
    nonNullType.isDartCoreString ||
    nonNullType.isDartCoreInt ||
    nonNullType.isDartCoreDouble ||
    nonNullType.isDartCoreNum ||
    nonNullType.isDartCoreBool;

bool _isJsInteropExtensionType(DartType nonNullType) =>
    nonNullType.element is ExtensionTypeElement;

bool _isJsCodableClass(DartType nonNullType) =>
    nonNullType is InterfaceType &&
    !nonNullType.isEnum &&
    jsonSerializableChecker.hasAnnotationOfExact(
      nonNullType.element,
      throwOnUnresolved: false,
    );

bool _isDynamicOrObject(DartType type) =>
    type is DynamicType || type.isDartCoreObject;

String _withNullability(String baseType, bool isNullable) {
  if (!isNullable || baseType.endsWith('?')) {
    return baseType;
  }
  return '$baseType?';
}

String fieldElementName(TypeHelperCtx ctx) => ctx.fieldElement.name ?? '';
