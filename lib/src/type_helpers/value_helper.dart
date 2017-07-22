import 'package:analyzer/dart/element/type.dart';
import '../type_helper.dart';

class ValueHelper extends TypeHelper {
  const ValueHelper();

  @override
  String serialize(DartType targetType, String expression, _) {
    if (targetType.isDynamic ||
        targetType.isObject ||
        simpleJsonTypeChecker.isAssignableFromType(targetType)) {
      return expression;
    }

    return null;
  }

  @override
  String deserialize(DartType targetType, String expression, _) {
    if (targetType.isDynamic || targetType.isObject) {
      // just return it as-is. We'll hope it's safe.
      return expression;
    } else if (simpleJsonTypeChecker.isAssignableFromType(targetType)) {
      return "$expression as $targetType";
    }

    return null;
  }
}
