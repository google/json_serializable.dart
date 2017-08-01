import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart' show TypeChecker;
import '../type_helper.dart';

/// Name used for closure argument when generating calls to `map`.
final _closureArg = 'e';

class IterableHelper extends TypeHelper {
  const IterableHelper();

  @override
  String serialize(DartType targetType, String expression, bool nullable,
      TypeHelperGenerator serializeNested) {
    if (!_coreIterableChecker.isAssignableFromType(targetType)) {
      return null;
    }

    // This block will yield a regular list, which works fine for JSON
    // Although it's possible that child elements may be marked unsafe

    var isList = _coreListChecker.isAssignableFromType(targetType);
    var subFieldValue = serializeNested(
        _getIterableGenericType(targetType), _closureArg, nullable);

    var optionalQuestion = nullable ? '?' : '';

    // In the case of trivial JSON types (int, String, etc), `subFieldValue`
    // will be identical to `substitute` – so no explicit mapping is needed.
    // If they are not equal, then we to write out the substitution.
    if (subFieldValue != _closureArg) {
      // TODO: the type could be imported from a library with a prefix!
      expression =
          '${expression}${optionalQuestion}.map(($_closureArg) => $subFieldValue)';

      // expression now represents an Iterable (even if it started as a List
      // ...resetting `isList` to `false`.
      isList = false;
    }

    if (!isList) {
      // If the static type is not a List, generate one.
      expression += '${optionalQuestion}.toList()';
    }

    return expression;
  }

  @override
  String deserialize(DartType targetType, String expression, bool nullable,
      TypeHelperGenerator deserializeNested) {
    if (!_coreIterableChecker.isAssignableFromType(targetType)) {
      return null;
    }

    var iterableGenericType = _getIterableGenericType(targetType);

    var itemSubVal =
        deserializeNested(iterableGenericType, _closureArg, nullable);

    // If `itemSubVal` is the same, then we don't need to do anything fancy
    if (_closureArg == itemSubVal) {
      return '$expression as List';
    }

    var optionalQuestion = nullable ? '?' : '';

    var output =
        '($expression as List)${optionalQuestion}.map(($_closureArg) => $itemSubVal)';

    if (_coreListChecker.isAssignableFromType(targetType)) {
      output += '${optionalQuestion}.toList()';
    }

    return output;
  }
}

DartType _getIterableGenericType(DartType type) =>
    typeArgumentsOf(type, _coreIterableChecker).single;

final _coreIterableChecker = const TypeChecker.fromUrl('dart:core#Iterable');

final _coreListChecker = const TypeChecker.fromUrl('dart:core#List');
