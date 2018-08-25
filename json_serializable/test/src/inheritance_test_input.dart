part of '_json_serializable_test_input.dart';

@ShouldGenerate(r'''
SubType _$SubTypeFromJson(Map<String, dynamic> json) {
  return SubType(
      json['subTypeViaCtor'] as int, json['super-final-field'] as int)
    ..superReadWriteField = json['superReadWriteField'] as int
    ..subTypeReadWrite = json['subTypeReadWrite'] as int;
}

Map<String, dynamic> _$SubTypeToJson(SubType instance) {
  var val = <String, dynamic>{
    'super-final-field': instance.superFinalField,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('superReadWriteField', instance.superReadWriteField);
  val['subTypeViaCtor'] = instance.subTypeViaCtor;
  val['subTypeReadWrite'] = instance.subTypeReadWrite;
  return val;
}
''', expectedWrappedOutput: r'''
SubType _$SubTypeFromJson(Map<String, dynamic> json) {
  return SubType(
      json['subTypeViaCtor'] as int, json['super-final-field'] as int)
    ..superReadWriteField = json['superReadWriteField'] as int
    ..subTypeReadWrite = json['subTypeReadWrite'] as int;
}

Map<String, dynamic> _$SubTypeToJson(SubType instance) =>
    _$SubTypeJsonMapWrapper(instance);

class _$SubTypeJsonMapWrapper extends $JsonMapWrapper {
  final SubType _v;
  _$SubTypeJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys sync* {
    yield 'super-final-field';
    if (_v.superReadWriteField != null) {
      yield 'superReadWriteField';
    }
    yield 'subTypeViaCtor';
    yield 'subTypeReadWrite';
  }

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'super-final-field':
          return _v.superFinalField;
        case 'superReadWriteField':
          return _v.superReadWriteField;
        case 'subTypeViaCtor':
          return _v.subTypeViaCtor;
        case 'subTypeReadWrite':
          return _v.subTypeReadWrite;
      }
    }
    return null;
  }
}
''')
@JsonSerializable()
class SubType extends SuperType {
  final int subTypeViaCtor;
  int subTypeReadWrite;

  SubType(this.subTypeViaCtor, int superFinalField) : super(superFinalField);
}

// NOTE: `SuperType` is intentionally after `SubType` in the source file to
// validate field ordering semantics.
class SuperType {
  @JsonKey(name: 'super-final-field', nullable: false)
  final int superFinalField;

  @JsonKey(includeIfNull: false)
  int superReadWriteField;

  SuperType(this.superFinalField);

  /// Add a property to try to throw-off the generator
  /// Since `priceHalf` is final and not in the constructor, it will be excluded
  int get priceHalf => priceFraction(2);

  /// Add a method to try to throw-off the generator
  int priceFraction(int other) =>
      superFinalField == null ? null : superFinalField ~/ other;
}
