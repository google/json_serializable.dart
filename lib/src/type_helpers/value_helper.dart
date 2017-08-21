import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart' show TypeChecker;
import '../type_helper.dart';

class ValueHelper extends TypeHelper {
  const ValueHelper();

  @override
  String serialize(DartType targetType, String expression, bool nullable, _) {
    if (targetType.isDynamic ||
        targetType.isObject ||
        simpleJsonTypeChecker.isAssignableFromType(targetType)) {
      return expression;
    }

    return null;
  }

  @override
  String deserialize(DartType targetType, String expression, bool nullable, _) {
    if (targetType.isDynamic || targetType.isObject) {
      // just return it as-is. We'll hope it's safe.
      return expression;
    } else if (const TypeChecker.fromRuntime(double)
        .isExactlyType(targetType)) {
      return '($expression as num)${nullable ? '?' : ''}.toDouble()';
    } else if (simpleJsonTypeChecker.isAssignableFromType(targetType)) {
      return '$expression as $targetType';
    }

    return null;
  }
}
