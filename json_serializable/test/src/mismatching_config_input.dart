// @dart=3.8

part of '_json_serializable_test_input.dart';

@JsonSerializable(createToJson: false)
sealed class SuperWithoutToJson {}

@JsonSerializable(createToJson: true)
sealed class SuperWithToJson {}

@ShouldThrow(
  'The class `SuperWithoutToJson` is sealed but its '
  'subclass `SubWithToJsonAndSuperWithoutToJsonExt` has a different '
  '`createToJson` option than the base class.',
  element: 'SubWithToJsonAndSuperWithoutToJsonExt',
)
@JsonSerializable(createToJson: true)
class SubWithToJsonAndSuperWithoutToJsonExt extends SuperWithoutToJson {}

@ShouldThrow(
  'The class `SuperWithoutToJson` is sealed but its '
  'subclass `SubWithToJsonAndSuperWithoutToJsonImpl` has a different '
  '`createToJson` option than the base class.',
  element: 'SubWithToJsonAndSuperWithoutToJsonImpl',
)
@JsonSerializable(createToJson: true)
class SubWithToJsonAndSuperWithoutToJsonImpl implements SuperWithoutToJson {}

@ShouldThrow(
  'The class `SuperWithToJson` is sealed but its '
  'subclass `SubWithoutToJsonAndSuperWithToJsonExt` has a different '
  '`createToJson` option than the base class.',
  element: 'SubWithoutToJsonAndSuperWithToJsonExt',
)
@JsonSerializable(createToJson: false)
class SubWithoutToJsonAndSuperWithToJsonExt extends SuperWithToJson {}

@ShouldThrow(
  'The class `SuperWithToJson` is sealed but its '
  'subclass `SubWithoutToJsonAndSuperWithToJsonImpl` has a different '
  '`createToJson` option than the base class.',
  element: 'SubWithoutToJsonAndSuperWithToJsonImpl',
)
@JsonSerializable(createToJson: false)
class SubWithoutToJsonAndSuperWithToJsonImpl implements SuperWithToJson {}
