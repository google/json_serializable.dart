part of '_json_serializable_test_input.dart';

@ShouldThrow(r'''
Could not generate `fromJson` code for `mapView`.
None of the provided `TypeHelper` instances support the defined type.''',
    'Make sure all of the types are serializable.')
@JsonSerializable(createToJson: false)
class UnsupportedMapField {
  MapView mapView;
}

@ShouldThrow(r'''
Could not generate `fromJson` code for `listView`.
None of the provided `TypeHelper` instances support the defined type.''',
    'Make sure all of the types are serializable.')
@JsonSerializable(createToJson: false)
class UnsupportedListField {
  UnmodifiableListView listView;
}

@ShouldThrow(r'''
Could not generate `fromJson` code for `customSet`.
None of the provided `TypeHelper` instances support the defined type.''',
    'Make sure all of the types are serializable.')
@JsonSerializable(createToJson: false)
class UnsupportedSetField {
  _CustomSet customSet;
}

abstract class _CustomSet implements Set {}
