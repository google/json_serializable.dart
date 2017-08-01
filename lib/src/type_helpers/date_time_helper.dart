import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart' show TypeChecker;
import '../type_helper.dart';
import 'type_helper_utils.dart';

class DateTimeHelper extends TypeHelper {
  const DateTimeHelper();

  @override
  String serialize(DartType targetType, String expression, bool nullable, _) {
    if (!_matchesType(targetType)) {
      return null;
    }

    var buffer = new StringBuffer(expression);

    if (nullable) {
      buffer.write('?');
    }

    buffer.write('.toIso8601String()');

    return buffer.toString();
  }

  @override
  String deserialize(DartType targetType, String expression, bool nullable, _) {
    if (!_matchesType(targetType)) {
      return null;
    }

    return commonNullPrefix(
        nullable, expression, 'DateTime.parse($expression as String)');
  }
}

bool _matchesType(DartType type) =>
    const TypeChecker.fromUrl('dart:core#DateTime').isExactlyType(type);
