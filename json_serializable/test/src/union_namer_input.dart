// @dart=3.8

part of '_json_serializable_test_input.dart';

@ShouldGenerate(r'''
SuperUnionRenameNone _$SuperUnionRenameNoneFromJson(
  Map<String, dynamic> json,
) => switch (json['type']) {
  'SubUnionRenameNone' => _$SubUnionRenameNoneFromJson(json),
  _ => throw UnrecognizedUnionTypeException(
    '${json['type']}',
    SuperUnionRenameNone,
    json,
  ),
};

Map<String, dynamic> _$SuperUnionRenameNoneToJson(
  SuperUnionRenameNone instance,
) => switch (instance) {
  final SubUnionRenameNone instance => {
    'type': 'SubUnionRenameNone',
    ..._$SubUnionRenameNoneToJson(instance),
  },
};
''')
@JsonSerializable(unionRename: FieldRename.none)
sealed class SuperUnionRenameNone {}

@ShouldGenerate(r'''
SubUnionRenameNone _$SubUnionRenameNoneFromJson(Map<String, dynamic> json) =>
    SubUnionRenameNone();

Map<String, dynamic> _$SubUnionRenameNoneToJson(SubUnionRenameNone instance) =>
    <String, dynamic>{};
''')
@JsonSerializable()
class SubUnionRenameNone extends SuperUnionRenameNone {}

@ShouldGenerate(r'''
SuperUnionRenameKebab _$SuperUnionRenameKebabFromJson(
  Map<String, dynamic> json,
) => switch (json['type']) {
  'sub-union-rename-kebab' => _$SubUnionRenameKebabFromJson(json),
  _ => throw UnrecognizedUnionTypeException(
    '${json['type']}',
    SuperUnionRenameKebab,
    json,
  ),
};

Map<String, dynamic> _$SuperUnionRenameKebabToJson(
  SuperUnionRenameKebab instance,
) => switch (instance) {
  final SubUnionRenameKebab instance => {
    'type': 'sub-union-rename-kebab',
    ..._$SubUnionRenameKebabToJson(instance),
  },
};
''')
@JsonSerializable(unionRename: FieldRename.kebab)
sealed class SuperUnionRenameKebab {}

@ShouldGenerate(r'''
SubUnionRenameKebab _$SubUnionRenameKebabFromJson(Map<String, dynamic> json) =>
    SubUnionRenameKebab();

Map<String, dynamic> _$SubUnionRenameKebabToJson(
  SubUnionRenameKebab instance,
) => <String, dynamic>{};
''')
@JsonSerializable()
class SubUnionRenameKebab extends SuperUnionRenameKebab {}

@ShouldGenerate(r'''
SuperUnionRenameSnake _$SuperUnionRenameSnakeFromJson(
  Map<String, dynamic> json,
) => switch (json['type']) {
  'sub_union_rename_snake' => _$SubUnionRenameSnakeFromJson(json),
  _ => throw UnrecognizedUnionTypeException(
    '${json['type']}',
    SuperUnionRenameSnake,
    json,
  ),
};

Map<String, dynamic> _$SuperUnionRenameSnakeToJson(
  SuperUnionRenameSnake instance,
) => switch (instance) {
  final SubUnionRenameSnake instance => {
    'type': 'sub_union_rename_snake',
    ..._$SubUnionRenameSnakeToJson(instance),
  },
};
''')
@JsonSerializable(unionRename: FieldRename.snake)
sealed class SuperUnionRenameSnake {}

@ShouldGenerate(r'''
SubUnionRenameSnake _$SubUnionRenameSnakeFromJson(Map<String, dynamic> json) =>
    SubUnionRenameSnake();

Map<String, dynamic> _$SubUnionRenameSnakeToJson(
  SubUnionRenameSnake instance,
) => <String, dynamic>{};
''')
@JsonSerializable()
class SubUnionRenameSnake extends SuperUnionRenameSnake {}

@ShouldGenerate(r'''
SuperUnionRenamePascal _$SuperUnionRenamePascalFromJson(
  Map<String, dynamic> json,
) => switch (json['type']) {
  'SubUnionRenamePascal' => _$SubUnionRenamePascalFromJson(json),
  _ => throw UnrecognizedUnionTypeException(
    '${json['type']}',
    SuperUnionRenamePascal,
    json,
  ),
};

Map<String, dynamic> _$SuperUnionRenamePascalToJson(
  SuperUnionRenamePascal instance,
) => switch (instance) {
  final SubUnionRenamePascal instance => {
    'type': 'SubUnionRenamePascal',
    ..._$SubUnionRenamePascalToJson(instance),
  },
};
''')
@JsonSerializable(unionRename: FieldRename.pascal)
sealed class SuperUnionRenamePascal {}

@ShouldGenerate(r'''
SubUnionRenamePascal _$SubUnionRenamePascalFromJson(
  Map<String, dynamic> json,
) => SubUnionRenamePascal();

Map<String, dynamic> _$SubUnionRenamePascalToJson(
  SubUnionRenamePascal instance,
) => <String, dynamic>{};
''')
@JsonSerializable()
class SubUnionRenamePascal extends SuperUnionRenamePascal {}

@ShouldGenerate(r'''
SuperUnionRenameScreamingSnake _$SuperUnionRenameScreamingSnakeFromJson(
  Map<String, dynamic> json,
) => switch (json['type']) {
  'SUB_UNION_RENAME_SCREAMING_SNAKE' => _$SubUnionRenameScreamingSnakeFromJson(
    json,
  ),
  _ => throw UnrecognizedUnionTypeException(
    '${json['type']}',
    SuperUnionRenameScreamingSnake,
    json,
  ),
};

Map<String, dynamic> _$SuperUnionRenameScreamingSnakeToJson(
  SuperUnionRenameScreamingSnake instance,
) => switch (instance) {
  final SubUnionRenameScreamingSnake instance => {
    'type': 'SUB_UNION_RENAME_SCREAMING_SNAKE',
    ..._$SubUnionRenameScreamingSnakeToJson(instance),
  },
};
''')
@JsonSerializable(unionRename: FieldRename.screamingSnake)
sealed class SuperUnionRenameScreamingSnake {}

@ShouldGenerate(r'''
SubUnionRenameScreamingSnake _$SubUnionRenameScreamingSnakeFromJson(
  Map<String, dynamic> json,
) => SubUnionRenameScreamingSnake();

Map<String, dynamic> _$SubUnionRenameScreamingSnakeToJson(
  SubUnionRenameScreamingSnake instance,
) => <String, dynamic>{};
''')
@JsonSerializable()
class SubUnionRenameScreamingSnake extends SuperUnionRenameScreamingSnake {}
