import 'package:analyzer/dart/element/type.dart';
import 'package:code_builder/code_builder.dart' hide RecordType;
import 'package:source_helper/source_helper.dart';

import '../default_container.dart';
import '../type_helper.dart';
import '../utils.dart';

class RecordHelper extends TypeHelper<TypeHelperContextWithConfig> {
  const RecordHelper();

  @override
  Expression? deserialize(
    DartType targetType,
    Expression expression,
    TypeHelperContextWithConfig context,
    bool defaultProvided,
  ) {
    if (targetType is! RecordType) return null;

    final positionalItems = <Expression>[];
    final namedItems = <String, Expression>{};

    const paramName = r'$jsonValue';

    var index = 1;
    for (var field in targetType.positionalFields) {
      final val = context.deserialize(
        field.type,
        refer(paramName).index(escapedStringLiteral('\$$index')),
      );
      positionalItems.add(val!);
      index++;
    }
    for (var field in targetType.namedFields) {
      final val = context.deserialize(
        field.type,
        refer(paramName).index(escapedStringLiteral(field.name)),
      );
      namedItems[field.name] = val!;
    }

    if (positionalItems.isEmpty && namedItems.isEmpty) {
      return DefaultContainer(expression, literalRecord([], {}));
    }

    final nullable = targetType.isNullableType || defaultProvided;

    context.addMember(
      _recordConvertImpl(nullable: nullable, anyMap: context.config.anyMap),
    );

    final recordLiteral = literalRecord(positionalItems, namedItems);

    final helperName = _recordConvertName(
      nullable: nullable,
      anyMap: context.config.anyMap,
    );

    final closure = Method(
      (m) => m
        ..requiredParameters.add(Parameter((p) => p..name = paramName))
        ..lambda = true
        ..body = recordLiteral.code,
    ).closure;

    return refer(helperName).call([expression, closure]);
  }

  @override
  Expression? serialize(
    DartType targetType,
    Expression expression,
    TypeHelperContextWithConfig context,
  ) {
    if (targetType is! RecordType) return null;

    final exprStr = toCodeString(expression);
    final isSimpleIdentifier = !exprStr.contains('.');
    final receiver = targetType.isNullableType && !isSimpleIdentifier
        ? expression.nullChecked
        : expression;

    final mapEntries = <Expression, Expression>{};

    var index = 1;
    for (var field in targetType.positionalFields) {
      final indexer = escapedStringLiteral('\$$index');
      final val = context.serialize(field.type, receiver.property('\$$index'));
      mapEntries[indexer] = val!;
      index++;
    }
    for (var field in targetType.namedFields) {
      final indexer = escapedStringLiteral(field.name);
      final val = context.serialize(field.type, receiver.property(field.name));
      mapEntries[indexer] = val!;
    }

    final mapLiteral = literalMap(
      mapEntries,
      refer('String'),
      refer('dynamic'),
    );

    return targetType.isNullableType
        ? expression.equalTo(literalNull).conditional(literalNull, mapLiteral)
        : mapLiteral;
  }
}

String _recordConvertName({required bool nullable, required bool anyMap}) =>
    '_\$recordConvert${anyMap ? 'Any' : ''}${nullable ? 'Nullable' : ''}';

String _recordConvertImpl({required bool nullable, required bool anyMap}) {
  final name = _recordConvertName(nullable: nullable, anyMap: anyMap);

  var expression =
      'convert(value as ${anyMap ? 'Map' : 'Map<String, dynamic>'})';
  if (nullable) {
    expression = ifNullOrElse('value', 'null', expression);
  }

  return '''
\$Rec${nullable ? '?' : ''} $name<\$Rec>(
  Object? value,
  \$Rec Function(Map) convert,
) =>
  $expression;
''';
}
