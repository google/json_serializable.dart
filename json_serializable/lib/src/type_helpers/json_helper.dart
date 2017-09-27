import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import '../type_helper.dart';
import 'type_helper_utils.dart';

class JsonHelper extends TypeHelper {
  const JsonHelper();

  /// Simply returns the [expression] provided.
  ///
  /// By default, JSON encoding in from `dart:convert` calls `toJson()` on
  /// provided objects.
  @override
  String serialize(DartType targetType, String expression, bool nullable, _) {
    // TODO(kevmoo): This should be checking for toJson method, but toJson might
    //   be gone during generation, so we'll have to check for the annotation.
    // In the mean time, just assume the `canSerialize` logic will work most of
    //   the time.
    if (!_canDeserialize(targetType)) {
      return null;
    }

    return expression;
  }

  @override
  String deserialize(DartType targetType, String expression, bool nullable, _) {
    if (!_canDeserialize(targetType)) {
      return null;
    }

    var classElement = targetType.element as ClassElement;
    var fromJsonCtor =
        classElement.constructors.firstWhere((ce) => ce.name == 'fromJson');
    // TODO: should verify that this type is a valid JSON type...but for now...
    var asCastType = fromJsonCtor.parameters.single.type;

    var asCast = '';
    if (!asCastType.isDynamic && !asCastType.isObject) {
      asCast = ' as $asCastType';
    }

    // TODO: the type could be imported from a library with a prefix!
    // github.com/dart-lang/json_serializable/issues/19
    var result = 'new ${targetType.name}.fromJson($expression$asCast)';

    return commonNullPrefix(nullable, expression, result);
  }
}

bool _canDeserialize(DartType type) {
  if (type is! InterfaceType) return false;

  var classElement = type.element as ClassElement;

  for (var ctor in classElement.constructors) {
    if (ctor.name == 'fromJson') {
      // TODO: validate that there are the right number and type of arguments
      return true;
    }
  }

  return false;
}
