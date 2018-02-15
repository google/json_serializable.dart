import 'package:analyzer/dart/element/type.dart';
import '../type_helper.dart';
import 'type_helper_utils.dart';

final simpleExpression = new RegExp('^[a-zA-Z_]+\$');

class EnumHelper extends TypeHelper {
  const EnumHelper();

  @override
  String serialize(DartType targetType, String expression, bool nullable,
      SerializeContext context) {
    if (targetType is InterfaceType && targetType.element.isEnum) {
      return commonNullPrefix(
          nullable, expression, "$expression.toString().split('.')[1]");
    }

    return null;
  }

  @override
  String deserialize(DartType targetType, String expression, bool nullable,
      DeserializeContext context) {
    if (targetType is InterfaceType && targetType.element.isEnum) {
      var wrappedExpression =
          simpleExpression.hasMatch(expression) ? expression : '{$expression}';

      return commonNullPrefix(
          nullable,
          expression,
          '$targetType.values.singleWhere('
          "(x) => x.toString() == '$targetType.\$$wrappedExpression')");
    }
    return null;
  }
}
