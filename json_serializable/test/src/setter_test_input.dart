// @dart=3.6

part of '_json_serializable_test_input.dart';

@ShouldGenerate(
  r'''
JustSetter _$JustSetterFromJson(Map<String, dynamic> json) => JustSetter();

Map<String, dynamic> _$JustSetterToJson(JustSetter instance) =>
    <String, dynamic>{};
''',
  expectedLogItems: ['Setters are ignored: JustSetter.someSetter'],
)
@JsonSerializable()
class JustSetter {
  set someSetter(Object name) {}
}

@ShouldGenerate(
  r'''
JustSetterNoToJson _$JustSetterNoToJsonFromJson(Map<String, dynamic> json) =>
    JustSetterNoToJson();
''',
  expectedLogItems: ['Setters are ignored: JustSetterNoToJson.someSetter'],
)
@JsonSerializable(createToJson: false)
class JustSetterNoToJson {
  set someSetter(Object name) {}
}

@ShouldGenerate(
  r'''
Map<String, dynamic> _$JustSetterNoFromJsonToJson(
        JustSetterNoFromJson instance) =>
    <String, dynamic>{};
''',
  expectedLogItems: ['Setters are ignored: JustSetterNoFromJson.someSetter'],
)
@JsonSerializable(createFactory: false)
class JustSetterNoFromJson {
  set someSetter(Object name) {}
}
