// @dart=3.8

part of '_json_serializable_test_input.dart';

// https://github.com/google/json_serializable.dart/issues/1437
@ShouldGenerate(
  r'''
CtorParamJsonKey _$CtorParamJsonKeyFromJson(Map<String, dynamic> json) =>
    CtorParamJsonKey(
      attributeOne: json['first'] as String,
      attributeTwo: json['second'] as String,
    );

Map<String, dynamic> _$CtorParamJsonKeyToJson(CtorParamJsonKey instance) =>
    <String, dynamic>{
      'first': instance.attributeOne,
      'second': instance.attributeTwo,
    };
''',
  expectedLogItems: [
    'Field `attributeOne` has conflicting `JsonKey.name` annotations: both '
        'constructor parameter and class field have this annotation. Using '
        'constructor parameter value.',
  ],
)
@JsonSerializable()
class CtorParamJsonKey {
  CtorParamJsonKey({
    @JsonKey(name: 'first') required this.attributeOne,
    @JsonKey(name: 'second') required this.attributeTwo,
  });

  @JsonKey(name: 'fake_first')
  final String attributeOne;

  // Duplicate annotation with exact same value does not give a warning.
  @JsonKey(name: 'second')
  final String attributeTwo;
}

@ShouldGenerate(
  r'''
CtorParamJsonKeyWithExtends _$CtorParamJsonKeyWithExtendsFromJson(
  Map<String, dynamic> json,
) => CtorParamJsonKeyWithExtends(
  attributeOne: json['fake_first'] as String,
  attributeTwo: json['two'] as String,
);

Map<String, dynamic> _$CtorParamJsonKeyWithExtendsToJson(
  CtorParamJsonKeyWithExtends instance,
) => <String, dynamic>{
  'fake_first': instance.attributeOne,
  'two': instance.attributeTwo,
};
''',
  expectedLogItems: [
    'Field `attributeTwo` has conflicting `JsonKey.name` annotations: both '
        'constructor parameter and class field have this annotation. Using '
        'constructor parameter value.',
  ],
)
@JsonSerializable()
class CtorParamJsonKeyWithExtends extends CtorParamJsonKey {
  CtorParamJsonKeyWithExtends({
    required super.attributeOne,
    @JsonKey(name: 'two') required super.attributeTwo,
  });
}
