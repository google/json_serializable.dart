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
      SerializeContext context) {
    if (!_coreMapChecker.isAssignableFromType(targetType)) {
      return null;
    }
    var args = typeArgumentsOf(targetType, _coreMapChecker);
    assert(args.length == 2);

    var keyType = args[0];
    var valueType = args[1];

    _checkSafeKeyType(expression, keyType);

    var subFieldValue = context.serialize(valueType, _closureArg, nullable);

    if (_closureArg == subFieldValue) {
      return expression;
    }

    if (context.useWrappers) {
      var method = '\$wrapMap';
      if (nullable) {
        method = '${method}HandleNull';
      }

      return '$method<$keyType, $valueType>($expression, ($_closureArg) => $subFieldValue)';
    }

    var result = 'new Map<String, dynamic>.fromIterables('
        '$expression.keys,'
        '$expression.values.map<dynamic>(($_closureArg) => $subFieldValue))';

    return commonNullPrefix(nullable, expression, result);
  }

  @override
  String deserialize(DartType targetType, String expression, bool nullable,
      DeserializeContext context) {
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

    _checkSafeKeyType(expression, keyArg);

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

    var itemSubVal = context.deserialize(valueArg, _closureArg, nullable);

    var result = 'new Map<String, $valueArg>.fromIterables('
        '($expression as Map<String, dynamic>).keys,'
        '($expression as Map).values.map((dynamic $_closureArg) => $itemSubVal))';

    return commonNullPrefix(nullable, expression, result);
  }

  void _checkSafeKeyType(String expression, DartType keyArg) {
    // We're not going to handle converting key types at the moment
    // So the only safe types for key are dynamic/Object/String
    var safeKey = keyArg.isDynamic ||
        keyArg.isObject ||
        _stringTypeChecker.isExactlyType(keyArg);

    if (!safeKey) {
      throw new UnsupportedTypeError(keyArg, expression,
          'The type of the Map key must be `String`, `Object` or `dynamic`.');
    }
  }
}

final _coreMapChecker = const TypeChecker.fromUrl('dart:core#Map');
final _stringTypeChecker = const TypeChecker.fromRuntime(String);
