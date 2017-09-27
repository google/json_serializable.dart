import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart' show TypeChecker;
import '../type_helper.dart';
import 'type_helper_utils.dart';

/// Name used for closure argument when generating calls to `map`.
final _closureArg = 'e';

class MapHelper extends TypeHelper {
  const MapHelper();

  @override
  String serialize(DartType targetType, String expression, bool nullable,
      TypeHelperGenerator serializeNested) {
    if (!_coreMapChecker.isAssignableFromType(targetType)) {
      return null;
    }
    var args = typeArgumentsOf(targetType, _coreMapChecker);
    assert(args.length == 2);

    var keyArg = args[0];
    var valueType = args[1];

    // We're not going to handle converting key types at the moment
    // So the only safe types for key are dynamic/Object/String
    var safeKey = keyArg.isDynamic ||
        keyArg.isObject ||
        _stringTypeChecker.isExactlyType(keyArg);

    if (!safeKey) {
      // TODO: should add some logic to `UnsupportedTypeError` to allow more
      //       details to be provided – such as this case where the `key` in
      //       `targetType` is not supported.
      throw new UnsupportedTypeError(targetType, expression);
    }

    var subFieldValue = serializeNested(valueType, _closureArg, nullable);

    if (_closureArg == subFieldValue) {
      return expression;
    }

    var result = 'new Map<String, dynamic>.fromIterables('
        '$expression.keys,'
        '$expression.values.map(($_closureArg) => $subFieldValue))';

    return commonNullPrefix(nullable, expression, result);
  }

  @override
  String deserialize(DartType targetType, String expression, bool nullable,
      TypeHelperGenerator deserializeNested) {
    if (!_coreMapChecker.isAssignableFromType(targetType)) {
      return null;
    }

    // Just pass through if
    //    key:   dynamic, Object, String
    //    value: dynamic, Object
    var typeArgs = typeArgumentsOf(targetType, _coreMapChecker);
    assert(typeArgs.length == 2);
    var keyArg = typeArgs.first;
    var valueArg = typeArgs.last;

    // We're not going to handle converting key types at the moment
    // So the only safe types for key are dynamic/Object/String
    var safeKey = keyArg.isDynamic ||
        keyArg.isObject ||
        _stringTypeChecker.isExactlyType(keyArg);

    if (!safeKey) {
      throw new UnsupportedTypeError(keyArg, expression);
    }

    // this is the trivial case. Do a runtime cast to the known type of JSON
    // map values - `Map<String, dynamic>`
    if (valueArg.isDynamic || valueArg.isObject) {
      return '$expression as Map<String, dynamic>';
    }

    if (simpleJsonTypeChecker.isAssignableFromType(valueArg)) {
      // No mapping of the values is required!

      var result = 'new Map<String, $valueArg>.from($expression as Map)';
      return commonNullPrefix(nullable, expression, result);
    }

    // In this case, we're going to create a new Map with matching reified
    // types.

    var itemSubVal = deserializeNested(valueArg, _closureArg, nullable);

    var result = 'new Map<String, $valueArg>.fromIterables('
        '($expression as Map<String, dynamic>).keys,'
        '($expression as Map).values.map(($_closureArg) => $itemSubVal))';

    return commonNullPrefix(nullable, expression, result);
  }
}

final _coreMapChecker = const TypeChecker.fromUrl('dart:core#Map');
final _stringTypeChecker = const TypeChecker.fromRuntime(String);
