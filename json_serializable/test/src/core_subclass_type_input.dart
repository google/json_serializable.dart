// @dart=2.10

part of '_json_serializable_test_input.dart';

@ShouldThrow(
  r'''
Could not generate `fromJson` code for `mapView`.
None of the provided `TypeHelper` instances support the defined type.''',
  todo: 'Make sure all of the types are serializable.',
  element: 'mapView',
)
@JsonSerializable(createToJson: false)
class UnsupportedMapField {
  late MapView mapView;
}

@ShouldThrow(
  r'''
Could not generate `fromJson` code for `listView`.
None of the provided `TypeHelper` instances support the defined type.''',
  todo: 'Make sure all of the types are serializable.',
  element: 'listView',
)
@JsonSerializable(createToJson: false)
class UnsupportedListField {
  late UnmodifiableListView listView;
}

@ShouldThrow(
  r'''
Could not generate `fromJson` code for `customSet`.
None of the provided `TypeHelper` instances support the defined type.''',
  todo: 'Make sure all of the types are serializable.',
  element: 'customSet',
)
@JsonSerializable(createToJson: false)
class UnsupportedSetField {
  late _CustomSet customSet;
}

abstract class _CustomSet implements Set {}

@ShouldThrow(
  r'''
Could not generate `fromJson` code for `customDuration`.
None of the provided `TypeHelper` instances support the defined type.''',
  todo: 'Make sure all of the types are serializable.',
  element: 'customDuration',
)
@JsonSerializable(createToJson: false)
class UnsupportedDurationField {
  late _CustomDuration customDuration;
}

abstract class _CustomDuration implements Duration {}

@ShouldThrow(
  r'''
Could not generate `fromJson` code for `customUri`.
None of the provided `TypeHelper` instances support the defined type.''',
  todo: 'Make sure all of the types are serializable.',
  element: 'customUri',
)
@JsonSerializable(createToJson: false)
class UnsupportedUriField {
  _CustomUri? customUri;
}

abstract class _CustomUri implements Uri {}

@ShouldThrow(
  r'''
Could not generate `fromJson` code for `customDateTime`.
None of the provided `TypeHelper` instances support the defined type.''',
  todo: 'Make sure all of the types are serializable.',
  element: 'customDateTime',
)
@JsonSerializable(createToJson: false)
class UnsupportedDateTimeField {
  late _CustomDateTime customDateTime;
}

abstract class _CustomDateTime implements DateTime {}
