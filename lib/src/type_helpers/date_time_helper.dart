import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart' show TypeChecker;
import '../type_helper.dart';

class DateTimeHelper extends TypeHelper {
  const DateTimeHelper();

  @override
  String serialize(DartType targetType, String expression, _) =>
      _matchesType(targetType) ? "$expression?.toIso8601String()" : null;

  @override
  String deserialize(DartType targetType, String expression, _) =>
      _matchesType(targetType)
          ?
          // TODO(kevmoo) `String` here is ignoring
          // github.com/dart-lang/json_serializable/issues/19
          "$expression == null ? null : DateTime.parse($expression as String)"
          : null;
}

bool _matchesType(DartType type) =>
    const TypeChecker.fromUrl('dart:core#DateTime').isExactlyType(type);
