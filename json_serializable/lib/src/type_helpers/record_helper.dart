import 'package:analyzer/dart/element/type.dart';
import 'package:source_helper/source_helper.dart';

import '../type_helper.dart';
import '../utils.dart';

class RecordHelper extends TypeHelper<TypeHelperContextWithConfig> {
  const RecordHelper();

  @override
  Object? deserialize(
    DartType targetType,
    String expression,
    TypeHelperContextWithConfig context,
    bool defaultProvided,
  ) {
    if (targetType is! RecordType) return null;

    final items = <Object>[];

    const paramName = r'$jsonValue';

    var index = 1;
    for (var field in targetType.positionalFields) {
      final indexer = escapeDartString('\$$index');
      items.add(
        context.deserialize(field.type, '$paramName[$indexer]')!,
      );
      index++;
    }
    for (var field in targetType.namedFields) {
      final indexer = escapeDartString(field.name);
      items.add(
        '${field.name}:'
        '${context.deserialize(field.type, '$paramName[$indexer]')!}',
      );
    }

    if (items.isEmpty) {
      return '()';
    }

    context.addMember(
      _recordConvertImpl(
          nullable: targetType.isNullableType, anyMap: context.config.anyMap),
    );

    final recordLiteral = '(${items.map((e) => '$e,').join()})';

    final helperName = _recordConvertName(
      nullable: targetType.isNullableType,
      anyMap: context.config.anyMap,
    );

    return '''
$helperName(
  $expression,
  ($paramName) => $recordLiteral,
)''';
  }

  @override
  Object? serialize(
    DartType targetType,
    String expression,
    TypeHelperContextWithConfig context,
  ) {
    if (targetType is! RecordType) return null;

    final maybeBang = targetType.isNullableType ? '!' : '';

    final items = <Object>[];

    var index = 1;
    for (var field in targetType.positionalFields) {
      final indexer = escapeDartString('\$$index');
      items.add(
        '$indexer:'
        '${context.serialize(field.type, '$expression$maybeBang.\$$index')!}',
      );
      index++;
    }
    for (var field in targetType.namedFields) {
      final indexer = escapeDartString(field.name);
      items.add(
        '$indexer:${context.serialize(
          field.type,
          '$expression$maybeBang.${field.name}',
        )!}',
      );
    }

    final mapValue = '<String, dynamic>{${items.map((e) => '$e,').join()}}';

    return targetType.isNullableType
        ? ifNullOrElse(
            expression,
            'null',
            mapValue,
          )
        : mapValue;
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
