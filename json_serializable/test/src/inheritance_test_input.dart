// @dart=3.6

part of '_json_serializable_test_input.dart';

@ShouldGenerate(r'''
SubType _$SubTypeFromJson(Map<String, dynamic> json) => SubType(
      (json['subTypeViaCtor'] as num).toInt(),
      (json['super-final-field'] as num).toInt(),
    )
      ..superReadWriteField = (json['superReadWriteField'] as num?)?.toInt()
      ..subTypeReadWrite = (json['subTypeReadWrite'] as num).toInt();

Map<String, dynamic> _$SubTypeToJson(SubType instance) => <String, dynamic>{
      'super-final-field': instance.superFinalField,
      if (instance.superReadWriteField case final value?)
        'superReadWriteField': value,
      'subTypeViaCtor': instance.subTypeViaCtor,
      'subTypeReadWrite': instance.subTypeReadWrite,
    };
''')
@JsonSerializable()
class SubType extends SuperType {
  late final int subTypeViaCtor;
  late int subTypeReadWrite;

  SubType(this.subTypeViaCtor, int superFinalField) : super(superFinalField);
}

// NOTE: `SuperType` is intentionally after `SubType` in the source file to
// validate field ordering semantics.
class SuperType {
  @JsonKey(name: 'super-final-field')
  final int? superFinalField;

  @JsonKey(includeIfNull: false)
  int? superReadWriteField;

  SuperType(this.superFinalField);

  /// Add a property to try to throw-off the generator
  /// Since `priceHalf` is final and not in the constructor, it will be excluded
  int get priceHalf => priceFraction(2);

  /// Add a method to try to throw-off the generator
  int priceFraction(int other) => superFinalField! ~/ other;
}

@ShouldGenerate(r'''
Map<String, dynamic> _$SubTypeWithAnnotatedFieldOverrideExtendsToJson(
        SubTypeWithAnnotatedFieldOverrideExtends instance) =>
    <String, dynamic>{
      'super-final-field': instance.superFinalField,
      if (instance.superReadWriteField case final value?)
        'superReadWriteField': value,
      'priceHalf': instance.priceHalf,
    };
''')
@JsonSerializable(createFactory: false)
class SubTypeWithAnnotatedFieldOverrideExtends extends SuperType {
  SubTypeWithAnnotatedFieldOverrideExtends(int super.superTypeViaCtor);
}

@ShouldGenerate(r'''
Map<String, dynamic>
    _$SubTypeWithAnnotatedFieldOverrideExtendsWithOverridesToJson(
            SubTypeWithAnnotatedFieldOverrideExtendsWithOverrides instance) =>
        <String, dynamic>{
          'priceHalf': instance.priceHalf,
          'superReadWriteField': instance.superReadWriteField,
          'super-final-field': instance.superFinalField,
        };
''')
@JsonSerializable(createFactory: false)
class SubTypeWithAnnotatedFieldOverrideExtendsWithOverrides extends SuperType {
  SubTypeWithAnnotatedFieldOverrideExtendsWithOverrides(
      int super.superTypeViaCtor);

  /// The annotation applied here overrides the annotation in [SuperType].
  @JsonKey(includeIfNull: true)
  @override
  int? get superReadWriteField => super.superReadWriteField;

  @override
  set superReadWriteField(int? value) {
    super.superReadWriteField = value;
  }

  /// The order is picked up by this override, but the annotation is still
  /// applied from [SuperType].
  @override
  int? get superFinalField => super.superFinalField;
}

@ShouldGenerate(r'''
Map<String, dynamic> _$SubTypeWithAnnotatedFieldOverrideImplementsToJson(
        SubTypeWithAnnotatedFieldOverrideImplements instance) =>
    <String, dynamic>{
      'superReadWriteField': instance.superReadWriteField,
      'superFinalField': instance.superFinalField,
    };
''')
@JsonSerializable(createFactory: false)
class SubTypeWithAnnotatedFieldOverrideImplements implements SuperType {
  // Note the order of fields in the output is determined by this class
  @override
  int? superReadWriteField;

  @JsonKey(includeToJson: false, includeFromJson: false)
  @override
  int get priceHalf => 42;

  /// Since the relationship is `implements` no [JsonKey] values from
  /// [SuperType] are honored.
  @override
  int get superFinalField => 42;

  @override
  int priceFraction(int other) => other;
}
