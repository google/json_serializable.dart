import 'package:analyzer/dart/element/type.dart';
import '../type_helper.dart';
import 'type_helper_utils.dart';

class EnumHelper extends TypeHelper {
  const EnumHelper();

  @override
  String serialize(DartType targetType, String expression, bool nullable,
      TypeHelperGenerator serializeNested) {
    if (targetType is InterfaceType && targetType.element.isEnum) {
      return commonNullPrefix(
          nullable, expression, "$expression.toString().split('.')[1]");
    }

    return null;
  }

  @override
  String deserialize(DartType targetType, String expression, bool nullable,
      TypeHelperGenerator deserializeNested) {
    if (targetType is InterfaceType && targetType.element.isEnum) {
      return commonNullPrefix(
          nullable,
          expression,
          '$targetType.values.singleWhere('
          '(x) => x.toString() == "$targetType.\${$expression}")');
    }
    return null;
  }
}
