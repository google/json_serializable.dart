part of '_json_serializable_test_input.dart';

@ShouldGenerate(
  r'''
UnknownCtorParamType _$UnknownCtorParamTypeFromJson(Map<String, dynamic> json) {
  return UnknownCtorParamType(json['number']);
}

Map<String, dynamic> _$UnknownCtorParamTypeToJson(
        UnknownCtorParamType instance) =>
    <String, dynamic>{'number': instance.number};
''',
  configurations: ['default'],
)
@JsonSerializable()
class UnknownCtorParamType {
  int number;

  // ignore: undefined_class, field_initializer_not_assignable, prefer_initializing_formals
  UnknownCtorParamType(Bob number) : number = number;
}

@ShouldGenerate(
  r'''
UnknownFieldType _$UnknownFieldTypeFromJson(Map<String, dynamic> json) {
  return UnknownFieldType()..number = json['number'];
}

Map<String, dynamic> _$UnknownFieldTypeToJson(UnknownFieldType instance) =>
    <String, dynamic>{'number': instance.number};
''',
  configurations: ['default'],
)
@JsonSerializable()
class UnknownFieldType {
  // ignore: undefined_class
  Bob number;
}

@ShouldGenerate(
  r'''
Map<String, dynamic> _$UnknownFieldTypeToJsonOnlyToJson(
        UnknownFieldTypeToJsonOnly instance) =>
    <String, dynamic>{'number': instance.number};
''',
  configurations: ['default'],
)
@JsonSerializable(createFactory: false)
class UnknownFieldTypeToJsonOnly {
  // ignore: undefined_class
  Bob number;
}

@ShouldGenerate(
  r'''
UnknownFieldTypeWithConvert _$UnknownFieldTypeWithConvertFromJson(
    Map<String, dynamic> json) {
  return UnknownFieldTypeWithConvert()
    ..number = json['number'] == null ? null : _everythingIs42(json['number']);
}

Map<String, dynamic> _$UnknownFieldTypeWithConvertToJson(
        UnknownFieldTypeWithConvert instance) =>
    _$UnknownFieldTypeWithConvertJsonMapWrapper(instance);

class _$UnknownFieldTypeWithConvertJsonMapWrapper extends $JsonMapWrapper {
  final UnknownFieldTypeWithConvert _v;
  _$UnknownFieldTypeWithConvertJsonMapWrapper(this._v);

  @override
  Iterable<String> get keys => const ['number'];

  @override
  dynamic operator [](Object key) {
    if (key is String) {
      switch (key) {
        case 'number':
          return _v.number == null ? null : _everythingIs42(_v.number);
      }
    }
    return null;
  }
}
''',
  configurations: ['wrapped'],
)
@ShouldGenerate(
  r'''
UnknownFieldTypeWithConvert _$UnknownFieldTypeWithConvertFromJson(
    Map<String, dynamic> json) {
  return UnknownFieldTypeWithConvert()
    ..number = json['number'] == null ? null : _everythingIs42(json['number']);
}

Map<String, dynamic> _$UnknownFieldTypeWithConvertToJson(
        UnknownFieldTypeWithConvert instance) =>
    <String, dynamic>{
      'number':
          instance.number == null ? null : _everythingIs42(instance.number)
    };
''',
  configurations: ['default'],
)
@JsonSerializable()
class UnknownFieldTypeWithConvert {
  @JsonKey(fromJson: _everythingIs42, toJson: _everythingIs42)
  // ignore: undefined_class
  Bob number;
}

dynamic _everythingIs42(Object input) => 42;
