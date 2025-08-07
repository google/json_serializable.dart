// @dart=3.8

part of '_json_serializable_test_input.dart';

@JsonSerializable(unionDiscriminator: 'this_will_conflict')
sealed class SuperWithConflictingSnakeCaseDiscriminator {}

@ShouldThrow(
  'The JSON key `this_will_conflict` is conflicting with the discriminator '
  'of sealed superclass `SuperWithConflictingSnakeCaseDiscriminator`',
  todo: 'Rename the field or the discriminator.',
  element: 'thisWillConflict',
)
@JsonSerializable(fieldRename: RenameType.snake)
class SubWithConflictingDiscriminatorWithFieldRenameExt
    extends SuperWithConflictingSnakeCaseDiscriminator {
  final String thisWillConflict;

  SubWithConflictingDiscriminatorWithFieldRenameExt({
    required this.thisWillConflict,
  });
}

@ShouldThrow(
  'The JSON key `this_will_conflict` is conflicting with the discriminator '
  'of sealed superclass `SuperWithConflictingSnakeCaseDiscriminator`',
  todo: 'Rename the field or the discriminator.',
  element: 'thisWillConflict',
)
@JsonSerializable(fieldRename: RenameType.snake)
class SubWithConflictingDiscriminatorWithFieldRenameImpl
    implements SuperWithConflictingSnakeCaseDiscriminator {
  final String thisWillConflict;

  SubWithConflictingDiscriminatorWithFieldRenameImpl({
    required this.thisWillConflict,
  });
}

@ShouldThrow(
  'The JSON key `this_will_conflict` is conflicting with the discriminator '
  'of sealed superclass `SuperWithConflictingSnakeCaseDiscriminator`',
  todo: 'Rename the field or the discriminator.',
  element: 'conflict',
)
@JsonSerializable()
class SubWithConflictingDiscriminatorWithJsonKeyExt
    extends SuperWithConflictingSnakeCaseDiscriminator {
  @JsonKey(name: 'this_will_conflict')
  final String conflict;

  SubWithConflictingDiscriminatorWithJsonKeyExt({required this.conflict});
}

@ShouldThrow(
  'The JSON key `this_will_conflict` is conflicting with the discriminator '
  'of sealed superclass `SuperWithConflictingSnakeCaseDiscriminator`',
  todo: 'Rename the field or the discriminator.',
  element: 'conflict',
)
@JsonSerializable()
class SubWithConflictingDiscriminatorWithJsonKeyImpl
    implements SuperWithConflictingSnakeCaseDiscriminator {
  @JsonKey(name: 'this_will_conflict')
  final String conflict;

  SubWithConflictingDiscriminatorWithJsonKeyImpl({required this.conflict});
}

@JsonSerializable(unionDiscriminator: 'conflict')
sealed class SuperWithConflictingDefaultCaseDiscriminator {}

@ShouldThrow(
  'The JSON key `conflict` is conflicting with the discriminator '
  'of sealed superclass `SuperWithConflictingDefaultCaseDiscriminator`',
  todo: 'Rename the field or the discriminator.',
  element: 'conflict',
)
@JsonSerializable()
class SubWithConflictingDiscriminatorWithDefaultNameExt
    extends SuperWithConflictingDefaultCaseDiscriminator {
  final String conflict;

  SubWithConflictingDiscriminatorWithDefaultNameExt({required this.conflict});
}

@ShouldThrow(
  'The JSON key `conflict` is conflicting with the discriminator '
  'of sealed superclass `SuperWithConflictingDefaultCaseDiscriminator`',
  todo: 'Rename the field or the discriminator.',
  element: 'conflict',
)
@JsonSerializable()
class SubWithConflictingDiscriminatorWithDefaultNameImpl
    extends SuperWithConflictingDefaultCaseDiscriminator {
  final String conflict;

  SubWithConflictingDiscriminatorWithDefaultNameImpl({required this.conflict});
}

@JsonSerializable(unionDiscriminator: 'this_will_conflict')
sealed class SuperSuperSuperWithConflictingNestedDiscriminator {}

@JsonSerializable(unionDiscriminator: 'this_is_fine')
sealed class SuperSuperWithConflictingNestedDiscriminator
    extends SuperSuperSuperWithConflictingNestedDiscriminator {}

@ShouldThrow(
  'The classes `SuperSuperSuperWithConflictingNestedDiscriminator` and '
  '`SuperWithConflictingNestedDiscriminator` are nested sealed classes, '
  'but they have the same discriminator `this_will_conflict`.',
  todo:
      'Rename one of the discriminators with `unionDiscriminator` '
      'field of `@JsonSerializable`.',
  element: 'SuperWithConflictingNestedDiscriminator',
)
@JsonSerializable(unionDiscriminator: 'this_will_conflict')
sealed class SuperWithConflictingNestedDiscriminator
    extends SuperSuperWithConflictingNestedDiscriminator {}
