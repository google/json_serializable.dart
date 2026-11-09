// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';

import 'json_literal_generator.dart';
import 'shared_checkers.dart';
import 'type_helpers/config_types.dart';
import 'utils.dart';

final _jsonKeyExpando = Expando<Map<ClassConfig, KeyConfig>>();

KeyConfig jsonKeyForField(FieldElement field, ClassConfig classAnnotation) =>
    (_jsonKeyExpando[field] ??= Map.identity())[classAnnotation] ??= _from(
      field,
      classAnnotation,
    );

KeyConfig _from(FieldElement element, ClassConfig classAnnotation) {
  final obj = jsonKeyAnnotation(element);
  final ctorParam = classAnnotation.ctorParams
      .where((e) => e.name == element.name)
      .singleOrNull;
  final ctorObj = ctorParam == null
      ? null
      : jsonKeyAnnotationForCtorParam(ctorParam);

  ConstantReader fallbackObjRead(String field) {
    if (ctorObj != null && !ctorObj.isNull) {
      final ctorReadResult = ctorObj.read(field);
      if (!ctorReadResult.isNull) {
        final fieldReadResult = obj.isNull ? null : obj.read(field);
        if (fieldReadResult != null &&
            fieldReadResult.objectValue != ctorReadResult.objectValue) {
          log.warning(
            'Field `${element.name}` has conflicting `JsonKey.$field` '
            'annotations: both constructor parameter and class field have '
            'this annotation. Using constructor parameter value.',
          );
        }

        return ctorReadResult;
      }
    }
    if (obj.isNull) {
      return ConstantReader(null);
    }
    return obj.read(field);
  }

  final ctorParamDefault = _ctorParamDefault(ctorParam);

  if (obj.isNull && (ctorObj == null || ctorObj.isNull)) {
    return _populateJsonKey(
      classAnnotation,
      element,
      defaultValue: ctorParamDefault,
      includeFromJson: classAnnotation.ignoreUnannotated ? false : null,
      includeToJson: classAnnotation.ignoreUnannotated ? false : null,
    );
  }

  /// Returns a literal value for [dartObject] if possible, otherwise throws
  /// an [InvalidGenerationSourceError] using [typeInformation] to describe
  /// the unsupported type.
  Object? literalForObject(
    String fieldName,
    DartObject dartObject,
    Iterable<String> typeInformation,
  ) {
    if (dartObject.isNull) {
      return null;
    }

    final reader = ConstantReader(dartObject);
    final recordValue = dartObject.toRecordValue();

    String? badType;
    if (reader.isSymbol) {
      badType = 'Symbol';
    } else if (reader.isType) {
      badType = 'Type';
    } else if (dartObject.type is FunctionType) {
      // Function types at the "root" are already handled. If they occur
      // here, it's because the function is nested instead of a collection
      // literal, which is NOT supported!
      badType = 'Function';
    } else if (!reader.isLiteral && recordValue == null) {
      badType = dartObject.type!.element?.name;
    }

    if (badType != null) {
      badType = typeInformation.followedBy([badType]).join(' > ');
      throwUnsupported(
        element,
        '`$fieldName` is `$badType`, it must be a literal.',
      );
    }

    if (reader.isDouble || reader.isInt || reader.isString || reader.isBool) {
      return reader.literalValue;
    }

    if (reader.isList) {
      return [
        for (var e in reader.listValue)
          literalForObject(fieldName, e, [...typeInformation, 'List']),
      ];
    }

    if (reader.isSet) {
      return {
        for (var e in reader.setValue)
          literalForObject(fieldName, e, [...typeInformation, 'Set']),
      };
    }

    if (reader.isMap) {
      final mapTypeInformation = [...typeInformation, 'Map'];
      return reader.mapValue.map(
        (k, v) => MapEntry(
          literalForObject(fieldName, k!, mapTypeInformation),
          literalForObject(fieldName, v!, mapTypeInformation),
        ),
      );
    }

    if (recordValue != null) {
      final recordTypeInformation = [...typeInformation, 'Record'];
      return (
        positional: [
          for (var e in recordValue.positional)
            literalForObject(fieldName, e, recordTypeInformation),
        ],
        named: recordValue.named.map(
          (k, v) => MapEntry(
            k,
            literalForObject(fieldName, v, recordTypeInformation),
          ),
        ),
      );
    }

    badType = typeInformation.followedBy(['$dartObject']).join(' > ');

    throwUnsupported(
      element,
      'The provided value is not supported: $badType. '
      'This may be an error in package:json_serializable. '
      'Please rerun your build with `--verbose` and file an issue.',
    );
  }

  /// Returns a literal object representing the value of [fieldName] in [obj].
  ///
  /// If [mustBeEnum] is `true`, throws an [InvalidGenerationSourceError] if
  /// either the annotated field is not an `enum` or `List` or if the value in
  /// [fieldName] is not an `enum` value.
  String? createAnnotationValue(String fieldName, {bool mustBeEnum = false}) {
    final annotationValue = fallbackObjRead(fieldName);

    if (annotationValue.isNull) {
      return null;
    }

    final objectValue = annotationValue.objectValue;
    final annotationType = objectValue.type!;

    if (annotationType is FunctionType) {
      // TODO: we could be a LOT more careful here, checking the return type
      // and the number of parameters. BUT! If any of those things are wrong
      // the generated code will be invalid, so skipping until we're bored
      // later

      final functionValue = objectValue.toFunctionValue()!;

      final invokeConst =
          functionValue is ConstructorElement && functionValue.isConst
          ? 'const '
          : '';

      return '$invokeConst${functionValue.qualifiedName}()';
    }

    final enumFields = iterateEnumFields(annotationType);

    if (enumFields != null) {
      if (mustBeEnum) {
        if (!element.type.isEnum &&
            !coreIterableTypeChecker.isAssignableFromType(element.type) &&
            !coreMapTypeChecker.isAssignableFromType(element.type)) {
          throwUnsupported(
            element,
            '`$fieldName` can only be set on fields of type enum or on '
            'Iterable, List, Set or Map instances of an enum type.',
          );
        }

        var targetEnumType = element.type;
        while (!targetEnumType.isEnum) {
          if (coreIterableTypeChecker.isAssignableFromType(targetEnumType)) {
            targetEnumType = coreIterableGenericType(targetEnumType);
          } else if (coreMapTypeChecker.isAssignableFromType(targetEnumType)) {
            targetEnumType = coreMapGenericValueType(targetEnumType);
          } else {
            break;
          }
        }

        if (_nullAsUnknownChecker.isExactlyType(annotationType) &&
            targetEnumType.isEnum) {
          return jsonKeyNullForUndefinedEnumValueFieldName;
        } else if (!_interfaceTypesEqual(annotationType, targetEnumType)) {
          throwUnsupported(
            element,
            '`$fieldName` has type '
            '`${targetEnumType.toStringNonNullable()}`, but '
            'the provided unknownEnumValue is of type '
            '`${annotationType.toStringNonNullable()}`.',
          );
        }
      }

      if (_nullAsUnknownChecker.isExactlyType(annotationType)) {
        throw InvalidGenerationSourceError(
          '`$jsonKeyNullForUndefinedEnumValueFieldName` cannot be used with '
          '`JsonKey.defaultValue`.',
          element: element,
        );
      }

      final enumValueNames = enumFields
          .map((p) => p.name!)
          .toList(growable: false);

      final enumValueName = enumValueForDartObject<String>(
        objectValue,
        enumValueNames,
        (n) => n,
      );

      return '${annotationType.element!.name}.$enumValueName';
    } else {
      final defaultValueLiteral = literalForObject(fieldName, objectValue, []);
      if (defaultValueLiteral == null) {
        return null;
      }
      if (mustBeEnum) {
        throwUnsupported(
          element,
          'The value provided for `$fieldName` must be a matching enum.',
        );
      }
      return jsonLiteralAsDart(defaultValueLiteral);
    }
  }

  final defaultValue = createAnnotationValue('defaultValue');
  if (defaultValue != null && ctorParamDefault != null) {
    if (defaultValue == ctorParamDefault) {
      log.info(
        'The default value `$defaultValue` for `${element.name!}` is defined '
        'twice in the constructor and in the `JsonKey.defaultValue`.',
      );
    } else {
      log.warning(
        'The constructor parameter for `${element.name!}` has a default value '
        '`$ctorParamDefault`, but the `JsonKey.defaultValue` value '
        '`$defaultValue` will be used for missing or `null` values in JSON '
        'decoding.',
      );
    }
  }

  String? readValueFunctionName;
  final readValue = fallbackObjRead('readValue');
  if (!readValue.isNull) {
    readValueFunctionName = readValue.objectValue
        .toFunctionValue()!
        .qualifiedName;
  }

  final ignore = fallbackObjRead('ignore').literalValue as bool?;
  var includeFromJson =
      fallbackObjRead('includeFromJson').literalValue as bool?;
  var includeToJson = fallbackObjRead('includeToJson').literalValue as bool?;

  if (ignore != null) {
    if (includeFromJson != null) {
      throwUnsupported(
        element,
        'Cannot use both `ignore` and `includeFromJson` on the same field. '
        'Since `ignore` is deprecated, you should only use `includeFromJson`.',
      );
    }
    if (includeToJson != null) {
      throwUnsupported(
        element,
        'Cannot use both `ignore` and `includeToJson` on the same field. '
        'Since `ignore` is deprecated, you should only use `includeToJson`.',
      );
    }
    assert(includeFromJson == null && includeToJson == null);
    includeToJson = includeFromJson = !ignore;
  }

  final explicitJsonNullWhenNonNullField =
      fallbackObjRead('explicitJsonNullWhenNonNullField').literalValue as bool?;

  return _populateJsonKey(
    classAnnotation,
    element,
    defaultValue: defaultValue ?? ctorParamDefault,
    disallowNullValue:
        fallbackObjRead('disallowNullValue').literalValue as bool?,
    explicitJsonNullWhenNonNullField: explicitJsonNullWhenNonNullField,
    includeIfNull: fallbackObjRead('includeIfNull').literalValue as bool?,
    name: fallbackObjRead('name').literalValue as String?,
    readValueFunctionName: readValueFunctionName,
    required: fallbackObjRead('required').literalValue as bool?,
    unknownEnumValue: createAnnotationValue(
      'unknownEnumValue',
      mustBeEnum: true,
    ),
    includeToJson: includeToJson,
    includeFromJson: includeFromJson,
  );
}

KeyConfig _populateJsonKey(
  ClassConfig classAnnotation,
  FieldElement element, {
  required String? defaultValue,
  bool? disallowNullValue,
  bool? explicitJsonNullWhenNonNullField,
  bool? includeIfNull,
  String? name,
  String? readValueFunctionName,
  bool? required,
  String? unknownEnumValue,
  bool? includeToJson,
  bool? includeFromJson,
}) {
  if (disallowNullValue == true) {
    if (includeIfNull == true) {
      throwUnsupported(
        element,
        'Cannot set both `disallowNullValue` and `includeIfNull` to `true`. '
        'This leads to incompatible `toJson` and `fromJson` behavior.',
      );
    }
  }

  if (explicitJsonNullWhenNonNullField == true) {
    if (!element.type.isNullableType) {
      throwUnsupported(
        element,
        'Fields with `explicitJsonNullWhenNonNullField` must be nullable so '
        'a missing JSON key can be represented as Dart `null`.',
      );
    }
    if (disallowNullValue == true) {
      throwUnsupported(
        element,
        'Cannot set both `explicitJsonNullWhenNonNullField` and '
        '`disallowNullValue` to `true`.',
      );
    }
    if (required == true) {
      throwUnsupported(
        element,
        'Cannot set both `explicitJsonNullWhenNonNullField` and `required` to '
        '`true`.',
      );
    }
    if (defaultValue != null) {
      throwUnsupported(
        element,
        'Cannot set `defaultValue` when `explicitJsonNullWhenNonNullField` is '
        '`true`.',
      );
    }
    if (readValueFunctionName != null) {
      throwUnsupported(
        element,
        'Cannot set `readValue` when `explicitJsonNullWhenNonNullField` is '
        '`true`.',
      );
    }
  }

  return KeyConfig(
    defaultValue: defaultValue,
    disallowNullValue: disallowNullValue ?? false,
    explicitJsonNullWhenNonNullField: explicitJsonNullWhenNonNullField ?? false,
    includeIfNull: _includeIfNull(
      includeIfNull,
      disallowNullValue,
      classAnnotation.includeIfNull,
    ),
    name: name ?? encodedFieldName(classAnnotation.fieldRename, element.name!),
    readValueFunctionName: readValueFunctionName,
    required: required ?? false,
    unknownEnumValue: unknownEnumValue,
    includeFromJson: includeFromJson,
    includeToJson: includeToJson,
  );
}

bool _includeIfNull(
  bool? keyIncludeIfNull,
  bool? keyDisallowNullValue,
  bool classIncludeIfNull,
) {
  if (keyDisallowNullValue == true) {
    assert(keyIncludeIfNull != true);
    return false;
  }
  return keyIncludeIfNull ?? classIncludeIfNull;
}

bool _interfaceTypesEqual(DartType a, DartType b) {
  if (a is InterfaceType && b is InterfaceType) {
    // Handle nullability case. Pretty sure this is fine for enums.
    return a.element == b.element;
  }
  return a == b;
}

const jsonKeyNullForUndefinedEnumValueFieldName =
    'JsonKey.nullForUndefinedEnumValue';

final _nullAsUnknownChecker = TypeChecker.typeNamed(
  JsonKey.nullForUndefinedEnumValue.runtimeType,
  inPackage: 'json_annotation',
);

String? _ctorParamDefault(FormalParameterElement? ctorParam) {
  final code = ctorParam?.defaultValueCode;
  if (code == null) {
    return null;
  }
  var param = ctorParam;
  Expression? initializer;
  while (param != null && initializer == null) {
    initializer = param.constantInitializer;
    param = param is SuperFormalParameterElement
        ? param.superConstructorParameter
        : null;
  }
  if (initializer == null) {
    return code;
  }
  // Work around `RecordLiteral.toSource()` omitting `const` (analyzer
  // <= 14.6.0) and single-positional trailing commas
  // (https://github.com/dart-lang/sdk/issues/64883), and
  // `RecordTypeAnnotation.toSource()` omitting single-positional trailing
  // commas (https://github.com/dart-lang/sdk/issues/61390).
  return _formatDefaultAst(initializer) ?? code;
}

String? _formatDefaultAst(AstNode node) {
  if (node is RecordLiteral) {
    return _formatRecordLiteral(node);
  }
  if (node is RecordTypeAnnotation) {
    return _formatRecordTypeAnnotation(node);
  }
  final children = <AstNode>[];
  node.visitChildren(_DirectChildCollector(children));
  if (children.isEmpty) {
    return null;
  }
  List<String?>? formattedChildren;
  for (var i = 0; i < children.length; i++) {
    final formatted = _formatDefaultAst(children[i]);
    if (formatted != null) {
      (formattedChildren ??= List<String?>.filled(children.length, null))[i] =
          formatted;
    }
  }
  if (formattedChildren == null) {
    return null;
  }
  if (node is StringInterpolation) {
    return [
      for (var i = 0; i < children.length; i++)
        formattedChildren[i] ?? children[i].toSource(),
    ].join();
  }
  return _spliceFormattedChildren(node.toSource(), children, formattedChildren);
}

String? _formatRecordLiteral(RecordLiteral node) {
  final prefix = node.constKeyword != null ? 'const ' : '';
  final fields = node.fields
      .map((f) => _formatDefaultAst(f) ?? f.toSource())
      .join(', ');
  final isSinglePositional = switch (node.staticType) {
    RecordType(:final positionalFields, :final namedFields) =>
      positionalFields.length == 1 && namedFields.isEmpty,
    _ => false,
  };
  final trailingComma = isSinglePositional ? ',' : '';
  final formatted = '$prefix($fields$trailingComma)';
  return formatted == node.toSource() ? null : formatted;
}

String? _formatRecordTypeAnnotation(RecordTypeAnnotation node) {
  final positional = node.positionalFields
      .map(_formatRecordTypeField)
      .join(', ');
  final named = node.namedFields;
  final namedCode = named == null
      ? null
      : '{${named.fields.map(_formatRecordTypeField).join(', ')}}';
  final body = switch ((node.positionalFields.length, namedCode)) {
    (1, null) => '$positional,',
    (> 0, final n?) => '$positional, $n',
    (_, final n?) => n,
    _ => positional,
  };
  final suffix = node.question != null ? '?' : '';
  final formatted = '($body)$suffix';
  return formatted == node.toSource() ? null : formatted;
}

String _formatRecordTypeField(RecordTypeAnnotationField field) {
  final type = _formatDefaultAst(field.type) ?? field.type.toSource();
  final name = field.name?.lexeme;
  return name == null ? type : '$type $name';
}

String? _spliceFormattedChildren(
  String raw,
  List<AstNode> children,
  List<String?> formattedChildren,
) {
  final buffer = StringBuffer();
  var cursor = 0;
  for (var i = 0; i < children.length; i++) {
    final childRaw = children[i].toSource();
    final matchIndex = _findChildInSource(raw, childRaw, cursor);
    if (matchIndex < 0) {
      return null;
    }
    buffer
      ..write(raw.substring(cursor, matchIndex))
      ..write(formattedChildren[i] ?? childRaw);
    cursor = matchIndex + childRaw.length;
  }
  buffer.write(raw.substring(cursor));
  return buffer.toString();
}

int _findChildInSource(String raw, String childRaw, int start) {
  if (childRaw.isEmpty) {
    return start;
  }
  final startsId = _isIdentifierChar(childRaw.codeUnitAt(0));
  final endsId = _isIdentifierChar(childRaw.codeUnitAt(childRaw.length - 1));
  for (
    var index = raw.indexOf(childRaw, start);
    index >= 0;
    index = raw.indexOf(childRaw, index + 1)
  ) {
    final validStart =
        !startsId ||
        index == start ||
        !_isIdentifierChar(raw.codeUnitAt(index - 1));
    final end = index + childRaw.length;
    final validEnd =
        !endsId || end == raw.length || !_isIdentifierChar(raw.codeUnitAt(end));
    if (validStart && validEnd) {
      return index;
    }
  }
  return -1;
}

bool _isIdentifierChar(int unit) =>
    (unit >= 0x30 && unit <= 0x39) || // 0-9
    (unit >= 0x41 && unit <= 0x5A) || // A-Z
    (unit >= 0x61 && unit <= 0x7A) || // a-z
    unit == 0x5F || // _
    unit == 0x24; // $

class _DirectChildCollector extends UnifyingAstVisitor<void> {
  final List<AstNode> children;

  _DirectChildCollector(this.children);

  @override
  void visitNode(AstNode node) {
    children.add(node);
  }
}
