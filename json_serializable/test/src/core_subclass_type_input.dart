part of '_json_serializable_test_input.dart';

@ShouldThrow(
  '''
Could not generate `fromJson` code for `mapView`.
$notSupportedWithTypeHelpersMsg''',
  element: 'mapView',
)
@JsonSerializable(createToJson: false)
class UnsupportedMapField {
  MapView mapView;
}

@ShouldThrow(
  '''
Could not generate `fromJson` code for `listView`.
$notSupportedWithTypeHelpersMsg''',
  element: 'listView',
)
@JsonSerializable(createToJson: false)
class UnsupportedListField {
  UnmodifiableListView listView;
}

@ShouldThrow(
  '''
Could not generate `fromJson` code for `customSet`.
$notSupportedWithTypeHelpersMsg''',
  element: 'customSet',
)
@JsonSerializable(createToJson: false)
class UnsupportedSetField {
  _CustomSet customSet;
}

abstract class _CustomSet implements Set {}

@ShouldThrow(
  '''
Could not generate `fromJson` code for `customDuration`.
$notSupportedWithTypeHelpersMsg''',
  element: 'customDuration',
)
@JsonSerializable(createToJson: false)
class UnsupportedDurationField {
  _CustomDuration customDuration;
}

abstract class _CustomDuration implements Duration {}

@ShouldThrow(
  '''
Could not generate `fromJson` code for `customUri`.
$notSupportedWithTypeHelpersMsg''',
  element: 'customUri',
)
@JsonSerializable(createToJson: false)
class UnsupportedUriField {
  _CustomUri customUri;
}

abstract class _CustomUri implements Uri {}

@ShouldThrow(
  '''
Could not generate `fromJson` code for `customDateTime`.
$notSupportedWithTypeHelpersMsg''',
  element: 'customDateTime',
)
@JsonSerializable(createToJson: false)
class UnsupportedDateTimeField {
  _CustomDateTime customDateTime;
}

abstract class _CustomDateTime implements DateTime {}
