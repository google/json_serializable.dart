// @dart=3.8

part of '_json_serializable_test_input.dart';

sealed class SuperWithoutSuperJsonSerializableAnnotation {}

@ShouldThrow(
  'The class `SubWithoutSuperJsonSerializableAnnotationExt` is annotated '
  'with `JsonSerializable` but its sealed superclass '
  '`SuperWithoutSuperJsonSerializableAnnotation` is not annotated '
  'with `JsonSerializable`.',
  element: 'SubWithoutSuperJsonSerializableAnnotationExt',
)
@JsonSerializable()
class SubWithoutSuperJsonSerializableAnnotationExt
    extends SuperWithoutSuperJsonSerializableAnnotation {}

@ShouldThrow(
  'The class `SubWithoutSuperJsonSerializableAnnotationImpl` is annotated '
  'with `JsonSerializable` but its sealed superclass '
  '`SuperWithoutSuperJsonSerializableAnnotation` is not annotated '
  'with `JsonSerializable`.',
  todo: 'Add `@JsonSerializable` annotation to the sealed class.',
  element: 'SubWithoutSuperJsonSerializableAnnotationImpl',
)
@JsonSerializable()
class SubWithoutSuperJsonSerializableAnnotationImpl
    implements SuperWithoutSuperJsonSerializableAnnotation {}

@ShouldThrow(
  'The class `SuperWithSubExtWithoutJsonSerializableAnnotation` is sealed but '
  'its subclass `SubWithoutJsonSerializableAnnotationExt` is not annotated '
  'with `JsonSerializable`.',
  todo:
      'Add `@JsonSerializable` annotation to '
      'SubWithoutJsonSerializableAnnotationExt.',
  element: 'SubWithoutJsonSerializableAnnotationExt',
)
@JsonSerializable()
sealed class SuperWithSubExtWithoutJsonSerializableAnnotation {}

class SubWithoutJsonSerializableAnnotationExt
    extends SuperWithSubExtWithoutJsonSerializableAnnotation {}

@ShouldThrow(
  'The class `SuperWithSubImplWithoutJsonSerializableAnnotation` is sealed but '
  'its subclass `SubWithoutJsonSerializableAnnotationImpl` is not annotated '
  'with `JsonSerializable`.',
  todo:
      'Add `@JsonSerializable` annotation to '
      'SubWithoutJsonSerializableAnnotationImpl.',
  element: 'SubWithoutJsonSerializableAnnotationImpl',
)
@JsonSerializable()
sealed class SuperWithSubImplWithoutJsonSerializableAnnotation {}

class SubWithoutJsonSerializableAnnotationImpl
    implements SuperWithSubImplWithoutJsonSerializableAnnotation {}
