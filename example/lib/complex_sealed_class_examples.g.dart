// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complex_sealed_class_examples.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Organization _$OrganizationFromJson(Map<String, dynamic> json) =>
    switch (json['organization']) {
      'Department' => _$DepartmentFromJson(json),
      _ => throw UnrecognizedUnionTypeException(
        '${json['organization']}',
        Organization,
        json,
      ),
    };

Map<String, dynamic> _$OrganizationToJson(Organization instance) =>
    switch (instance) {
      final Department instance => {
        'organization': 'Department',
        ..._$DepartmentToJson(instance),
      },
    };

Department _$DepartmentFromJson(Map<String, dynamic> json) =>
    switch (json['department']) {
      'Team' => _$TeamFromJson(json),
      _ => throw UnrecognizedUnionTypeException(
        '${json['department']}',
        Department,
        json,
      ),
    };

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    switch (instance) {
      final Team instance => {'department': 'Team', ..._$TeamToJson(instance)},
    };

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
  teamLead: json['teamLead'] as String,
  departmentHead: json['departmentHead'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
  'name': instance.name,
  'departmentHead': instance.departmentHead,
  'teamLead': instance.teamLead,
};
