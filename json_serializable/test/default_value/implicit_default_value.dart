import 'package:json_annotation/json_annotation.dart';

import 'default_value_interface.dart';
import 'default_value_interface.dart' as dvi hide Greek;

part 'implicit_default_value.g.dart';

dvi.DefaultValue fromJson(Map<String, dynamic> json) =>
    _$DefaultValueImplicitFromJson(json);

@JsonSerializable()
class DefaultValueImplicit implements dvi.DefaultValue {
  @override
  final bool fieldBool;
  @override
  final String fieldString;
  @override
  final int fieldInt;
  @override
  final double fieldDouble;
  @override
  final List fieldListEmpty;
  @override
  final Set fieldSetEmpty;
  @override
  final Map fieldMapEmpty;
  @override
  final List<int> fieldListSimple;
  @override
  final Set<String> fieldSetSimple;
  @override
  final Map<String, int> fieldMapSimple;
  @override
  final Map<String, List<String>> fieldMapListString;
  @override
  final Greek fieldEnum;
  @override
  final ConstClass constClass;

  DefaultValueImplicit({
    this.fieldBool = true,
    this.fieldString = 'string',
    this.fieldInt = 42,
    this.fieldDouble = 3.14,
    this.fieldListEmpty = const [],
    this.fieldSetEmpty = const {},
    this.fieldMapEmpty = const {},
    this.fieldListSimple = const [1, 2, 3],
    this.fieldSetSimple = const {'entry1', 'entry2'},
    this.fieldMapSimple = const {'answer': 42},
    this.fieldMapListString = const {
      'root': ['child']
    },
    this.fieldEnum = Greek.beta,
    this.constClass = const ConstClass('value'),
  });

  factory DefaultValueImplicit.fromJson(Map<String, dynamic> json) =>
      _$DefaultValueImplicitFromJson(json);

  Map<String, dynamic> toJson() => _$DefaultValueImplicitToJson(this);
}

// Regression for https://github.com/google/json_serializable.dart/issues/903
@JsonSerializable()
class ConstClass {
  final String field;

  const ConstClass(this.field);

  factory ConstClass.fromJson(Map<String, dynamic> json) =>
      _$ConstClassFromJson(json);

  Map<String, dynamic> toJson() => _$ConstClassToJson(this);
}
