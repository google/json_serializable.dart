// Copyright (c) 2026, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

bool _listEquals<T>(List<T> a, List<T> b) {
  if (identical(a, b)) return true;
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

bool _setEquals<T>(Set<T> a, Set<T> b) =>
    a.length == b.length && a.containsAll(b);

bool _mapEquals<K, V>(Map<K, V> a, Map<K, V> b) {
  if (identical(a, b)) return true;
  if (a.length != b.length) return false;
  for (final entry in a.entries) {
    if (!b.containsKey(entry.key)) return false;
    final aVal = entry.value;
    final bVal = b[entry.key];
    if (aVal is List && bVal is List) {
      if (!_listEquals(aVal, bVal)) return false;
    } else if (aVal is Map && bVal is Map) {
      if (!_mapEquals(aVal, bVal)) return false;
    } else if (aVal != bVal) {
      return false;
    }
  }
  return true;
}

enum Role {
  @JsonValue('admin')
  admin,
  @JsonValue('member')
  member,
  @JsonValue('guest')
  guest,
}

@JsonEnum(valueField: 'code')
enum Priority {
  low(1),
  medium(2),
  high(3);

  const Priority(this.code);
  final int code;
}

class CustomId {
  final String value;
  const CustomId(this.value);

  @override
  bool operator ==(Object other) => other is CustomId && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'CustomId($value)';
}

class CustomIdConverter extends JsonConverter<CustomId, String> {
  const CustomIdConverter();

  @override
  CustomId fromJson(String json) => CustomId(json.substring('id:'.length));

  @override
  String toJson(CustomId object) => 'id:${object.value}';
}

class MetadataBag {
  final Map<String, Object?> data;
  const MetadataBag(this.data);

  @override
  bool operator ==(Object other) =>
      other is MetadataBag && _mapEquals(other.data, data);

  @override
  int get hashCode => Object.hashAll(data.keys);

  @override
  String toString() => 'MetadataBag($data)';
}

class MetadataBagConverter
    extends JsonConverter<MetadataBag, Map<String, dynamic>> {
  const MetadataBagConverter();

  @override
  MetadataBag fromJson(Map<String, dynamic> json) =>
      MetadataBag(Map<String, Object?>.from(json));

  @override
  Map<String, dynamic> toJson(MetadataBag object) =>
      Map<String, dynamic>.from(object.data);
}

DateTime epochMillisFromJson(int millis) =>
    DateTime.fromMillisecondsSinceEpoch(millis, isUtc: true);

int epochMillisToJson(DateTime dt) => dt.toUtc().millisecondsSinceEpoch;

@JsonSerializable()
class Child {
  final String id;
  final int count;
  final String? label;

  const Child({required this.id, required this.count, this.label});

  @override
  bool operator ==(Object other) =>
      other is Child &&
      other.id == id &&
      other.count == count &&
      other.label == label;

  @override
  int get hashCode => Object.hash(id, count, label);

  @override
  String toString() => 'Child(id: $id, count: $count, label: $label)';
}

class BaseEntity {
  final String id;
  final int baseScore;

  const BaseEntity({required this.id, required this.baseScore});
}

@JsonSerializable(fieldRename: FieldRename.snake)
class DerivedEntity extends BaseEntity {
  @JsonKey(name: 'entity_id')
  @override
  String get id => super.id;

  final String title;
  final int version;

  const DerivedEntity({
    required super.id,
    super.baseScore = 10,
    required this.title,
    this.version = 1,
  });

  @override
  bool operator ==(Object other) =>
      other is DerivedEntity &&
      other.id == id &&
      other.baseScore == baseScore &&
      other.title == title &&
      other.version == version;

  @override
  int get hashCode => Object.hash(id, baseScore, title, version);
}

@JsonSerializable(fieldRename: FieldRename.snake)
@CustomIdConverter()
@MetadataBagConverter()
class UserProfile {
  final CustomId customId;
  final String firstName;
  final int loginCount;
  final double rating;
  final num score;
  final bool isActive;
  final String? nickname;
  final int? optionalCount;

  @JsonKey(defaultValue: 'standard')
  final String tier;

  @JsonKey(name: 'custom_name')
  final String customNamedField;

  @JsonKey(name: 'kebab-key')
  final String kebabKey;

  @JsonKey(name: 'dot.key')
  final String? dotKey;

  final DateTime createdAt;
  final DateTime? lastLogin;
  final Uri homepage;
  final Uri? avatarUri;
  final BigInt quotaBytes;
  final Duration sessionDuration;
  final Duration? idleTimeout;

  final Role primaryRole;
  final Role? secondaryRole;
  final Priority priority;

  final Child primaryChild;
  final Child? optionalChild;

  final List<String> tags;
  final List<int> luckyNumbers;
  final Set<String> permissions;
  final List<Child> children;

  final Map<String, int> counters;
  final Map<String, Child> childByKey;

  @JsonKey(fromJson: epochMillisFromJson, toJson: epochMillisToJson)
  final DateTime epochTimestamp;

  final MetadataBag metadata;

  const UserProfile({
    required this.customId,
    required this.firstName,
    this.loginCount = 0,
    required this.rating,
    required this.score,
    required this.isActive,
    this.nickname,
    this.optionalCount,
    this.tier = 'standard',
    required this.customNamedField,
    required this.kebabKey,
    this.dotKey,
    required this.createdAt,
    this.lastLogin,
    required this.homepage,
    this.avatarUri,
    required this.quotaBytes,
    required this.sessionDuration,
    this.idleTimeout,
    required this.primaryRole,
    this.secondaryRole,
    this.priority = Priority.medium,
    required this.primaryChild,
    this.optionalChild,
    required this.tags,
    required this.luckyNumbers,
    required this.permissions,
    required this.children,
    required this.counters,
    required this.childByKey,
    required this.epochTimestamp,
    required this.metadata,
  });

  @override
  bool operator ==(Object other) {
    if (other is! UserProfile) return false;
    return other.customId == customId &&
        other.firstName == firstName &&
        other.loginCount == loginCount &&
        other.rating == rating &&
        other.score == score &&
        other.isActive == isActive &&
        other.nickname == nickname &&
        other.optionalCount == optionalCount &&
        other.tier == tier &&
        other.customNamedField == customNamedField &&
        other.kebabKey == kebabKey &&
        other.dotKey == dotKey &&
        other.createdAt == createdAt &&
        other.lastLogin == lastLogin &&
        other.homepage == homepage &&
        other.avatarUri == avatarUri &&
        other.quotaBytes == quotaBytes &&
        other.sessionDuration == sessionDuration &&
        other.idleTimeout == idleTimeout &&
        other.primaryRole == primaryRole &&
        other.secondaryRole == secondaryRole &&
        other.priority == priority &&
        other.primaryChild == primaryChild &&
        other.optionalChild == optionalChild &&
        _listEquals(other.tags, tags) &&
        _listEquals(other.luckyNumbers, luckyNumbers) &&
        _setEquals(other.permissions, permissions) &&
        _listEquals(other.children, children) &&
        _mapEquals(other.counters, counters) &&
        _mapEquals(other.childByKey, childByKey) &&
        other.epochTimestamp == epochTimestamp &&
        other.metadata == metadata;
  }

  @override
  int get hashCode => Object.hashAll([
    customId,
    firstName,
    loginCount,
    rating,
    score,
    isActive,
    nickname,
    optionalCount,
    tier,
    customNamedField,
    kebabKey,
    dotKey,
    createdAt,
    lastLogin,
    homepage,
    avatarUri,
    quotaBytes,
    sessionDuration,
    idleTimeout,
    primaryRole,
    secondaryRole,
    priority,
    primaryChild,
    optionalChild,
    Object.hashAll(tags),
    Object.hashAll(luckyNumbers),
    Object.hashAll(permissions),
    Object.hashAll(children),
    Object.hashAll(counters.keys),
    Object.hashAll(childByKey.keys),
    epochTimestamp,
    metadata,
  ]);
}
