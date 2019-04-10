part of '_json_serializable_test_input.dart';

@ShouldThrow(
  'Could not generate `fromJson` code for `number` because the type '
  'is undefined.',
  expectedLogItems: [
    '''
This element has an undefined type. It may causes issues when generated code.
package:__test__/unknown_type_test_input.dart:25:28
   ╷
25 │   UnknownCtorParamType(Bob number) : number = number;
   │                            ^^^^^^
   ╵'''
  ],
  todo: 'Check your imports. If you\'re trying to generate code for a '
      'Platform-provided type, you may have to specify a custom `fromJson` '
      'in the associated `@JsonKey` annotation.',
  configurations: ['default'],
)
@JsonSerializable()
class UnknownCtorParamType {
  int number;

  // ignore: undefined_class, field_initializer_not_assignable, prefer_initializing_formals
  UnknownCtorParamType(Bob number) : number = number;
}

@ShouldThrow(
  'Could not generate `fromJson` code for `number` because the type '
  'is undefined.',
  expectedLogItems: [
    '''
This element has an undefined type. It may causes issues when generated code.
package:__test__/unknown_type_test_input.dart:48:7
   ╷
48 │   Bob number;
   │       ^^^^^^
   ╵'''
  ],
  todo: 'Check your imports. If you\'re trying to generate code for a '
      'Platform-provided type, you may have to specify a custom `fromJson` '
      'in the associated `@JsonKey` annotation.',
  configurations: ['default'],
)
@JsonSerializable()
class UnknownFieldType {
  // ignore: undefined_class
  Bob number;
}

@ShouldThrow(
  'Could not generate `toJson` code for `number` because the type '
  'is undefined.',
  expectedLogItems: [
    '''
This element has an undefined type. It may causes issues when generated code.
package:__test__/unknown_type_test_input.dart:71:7
   ╷
71 │   Bob number;
   │       ^^^^^^
   ╵'''
  ],
  todo: 'Check your imports. If you\'re trying to generate code for a '
      'Platform-provided type, you may have to specify a custom `toJson` '
      'in the associated `@JsonKey` annotation.',
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
    <String, dynamic>{
      'number':
          instance.number == null ? null : _everythingIs42(instance.number)
    };
''',
  configurations: ['default'],
  expectedLogItems: [
    '''
This element has an undefined type. It may causes issues when generated code.
package:__test__/unknown_type_test_input.dart:104:7
    ╷
104 │   Bob number;
    │       ^^^^^^
    ╵'''
  ],
)
@JsonSerializable()
class UnknownFieldTypeWithConvert {
  @JsonKey(fromJson: _everythingIs42, toJson: _everythingIs42)
  // ignore: undefined_class
  Bob number;
}

dynamic _everythingIs42(Object input) => 42;
