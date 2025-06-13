import 'package:json_annotation/json_annotation.dart';

part 'complex_sealed_class_examples.g.dart';

@JsonSerializable(unionDiscriminator: 'organization')
sealed class Organization {
  final String name;

  Organization({required this.name});

  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationToJson(this);
}

@JsonSerializable(unionDiscriminator: 'department')
sealed class Department extends Organization {
  final String departmentHead;

  Department({required this.departmentHead, required super.name});

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);
}

@JsonSerializable()
class Team extends Department {
  final String teamLead;

  Team({
    required this.teamLead,
    required super.departmentHead,
    required super.name,
  });
}
