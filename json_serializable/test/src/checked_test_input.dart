part of '_json_serializable_test_input.dart';

@ShouldGenerate(r'''
WithANonCtorGetterChecked _$WithANonCtorGetterCheckedFromJson(
    Map<String, dynamic> json) {
  return $checkedNew('WithANonCtorGetterChecked', json, () {
    $checkKeys(json, allowedKeys: ['items']);
    var val = WithANonCtorGetterChecked($checkedConvert(
        json, 'items', (v) => (v as List)?.map((e) => e as String)?.toList()));
    return val;
  });
}
''', checked: true)
@JsonSerializable(disallowUnrecognizedKeys: true, createToJson: false)
class WithANonCtorGetterChecked {
  final List<String> items;
  int get legth => items.length;

  WithANonCtorGetterChecked(this.items);
}

@ShouldGenerate(r'''
WithANonCtorGetter _$WithANonCtorGetterFromJson(Map<String, dynamic> json) {
  $checkKeys(json, allowedKeys: ['items']);
  return WithANonCtorGetter(
      (json['items'] as List)?.map((e) => e as String)?.toList());
}
''')
@JsonSerializable(disallowUnrecognizedKeys: true, createToJson: false)
class WithANonCtorGetter {
  final List<String> items;
  int get legth => items.length;

  WithANonCtorGetter(this.items);
}
