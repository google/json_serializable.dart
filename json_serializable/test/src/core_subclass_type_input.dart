part of '_json_serializable_test_input.dart';

@ShouldThrow(
  '''
Could not generate `fromJson` code for `mapView`.
To support the type `MapView` you can:
$converterOrKeyInstructions''',
  element: 'mapView',
)
@JsonSerializable(createToJson: false)
class UnsupportedMapField {
  late MapView mapView;
}

@ShouldThrow(
  '''
Could not generate `fromJson` code for `listView`.
To support the type `UnmodifiableListView` you can:
$converterOrKeyInstructions''',
  element: 'listView',
)
@JsonSerializable(createToJson: false)
class UnsupportedListField {
  late UnmodifiableListView listView;
}

@ShouldThrow(
  '''
Could not generate `fromJson` code for `customSet`.
To support the type `CustomSet` you can:
$converterOrKeyInstructions''',
  element: 'customSet',
)
@JsonSerializable(createToJson: false)
class UnsupportedSetField {
  late CustomSet customSet;
}

abstract class CustomSet implements Set {}

@ShouldThrow(
  '''
Could not generate `fromJson` code for `customDuration`.
To support the type `CustomDuration` you can:
$converterOrKeyInstructions''',
  element: 'customDuration',
)
@JsonSerializable(createToJson: false)
class UnsupportedDurationField {
  late CustomDuration customDuration;
}

abstract class CustomDuration implements Duration {}

@ShouldThrow(
  '''
Could not generate `fromJson` code for `customUri`.
To support the type `CustomUri` you can:
$converterOrKeyInstructions''',
  element: 'customUri',
)
@JsonSerializable(createToJson: false)
class UnsupportedUriField {
  CustomUri? customUri;
}

abstract class CustomUri implements Uri {}

@ShouldThrow(
  '''
Could not generate `fromJson` code for `customDateTime`.
To support the type `CustomDateTime` you can:
$converterOrKeyInstructions''',
  element: 'customDateTime',
)
@JsonSerializable(createToJson: false)
class UnsupportedDateTimeField {
  late CustomDateTime customDateTime;
}

abstract class CustomDateTime implements DateTime {}
