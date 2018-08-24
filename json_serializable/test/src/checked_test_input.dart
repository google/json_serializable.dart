part of '_json_serializable_test_input.dart';

@ShouldGenerate(r'''
CheckedWithANonCtorGetter _$CheckedWithANonCtorGetterFromJson(
    Map<String, dynamic> json) {
  return $checkedNew('CheckedWithANonCtorGetter', json, () {
    $checkKeys(json, allowedKeys: ['items', 'legth']);
    var val = CheckedWithANonCtorGetter($checkedConvert(
        json, 'items', (v) => (v as List)?.map((e) => e as String)?.toList()));
    return val;
  });
}

Map<String, dynamic> _$CheckedWithANonCtorGetterToJson(
        CheckedWithANonCtorGetter instance) =>
    <String, dynamic>{'items': instance.items};
''', checked: true)
@JsonSerializable(disallowUnrecognizedKeys: true)
class CheckedWithANonCtorGetter {
  final List<String> items;
  int get legth => items.length;

  CheckedWithANonCtorGetter(this.items);
}
