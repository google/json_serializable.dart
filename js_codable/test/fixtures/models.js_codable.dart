// GENERATED CODE - DO NOT MODIFY BY HAND

import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

extension type const ChildJS._(JSObject _) implements JSObject {
  external factory ChildJS({
    required String id,
    required int count,
    String? label,
  });

  factory ChildJS.fromDart(Child instance) => $ChildToJs(instance);

  external String get id;
  external int get count;
  external String? get label;
  Child toDart() => $ChildFromJs(this);
}

extension ChildJsCodableExtension on Child {
  ChildJS toJs() => $ChildToJs(this);
}

Child $ChildFromJs(ChildJS js) =>
    Child(id: js.id, count: js.count, label: js.label);
ChildJS $ChildToJs(Child instance) =>
    ChildJS(id: instance.id, count: instance.count, label: instance.label);

extension type const DerivedEntityJS._(JSObject _) implements JSObject {
  external factory DerivedEntityJS({
    @JS('base_score') required int baseScore,
    @JS('entity_id') required String id,
    required String title,
    required int version,
  });

  factory DerivedEntityJS.fromDart(DerivedEntity instance) =>
      $DerivedEntityToJs(instance);

  @JS('base_score')
  external int? get baseScore;
  @JS('entity_id')
  external String get id;
  external String get title;
  external int? get version;
  DerivedEntity toDart() => $DerivedEntityFromJs(this);
}

extension DerivedEntityJsCodableExtension on DerivedEntity {
  DerivedEntityJS toJs() => $DerivedEntityToJs(this);
}

DerivedEntity $DerivedEntityFromJs(DerivedEntityJS js) => DerivedEntity(
  id: js.id,
  baseScore: js.baseScore ?? 10,
  title: js.title,
  version: js.version ?? 1,
);
DerivedEntityJS $DerivedEntityToJs(DerivedEntity instance) => DerivedEntityJS(
  baseScore: instance.baseScore,
  id: instance.id,
  title: instance.title,
  version: instance.version,
);

extension type const UserProfileJS._(JSObject _) implements JSObject {
  external factory UserProfileJS({
    @JS('custom_id') required String customId,
    @JS('first_name') required String firstName,
    @JS('login_count') required int loginCount,
    required double rating,
    required num score,
    @JS('is_active') required bool isActive,
    String? nickname,
    @JS('optional_count') int? optionalCount,
    required String tier,
    @JS('custom_name') required String customNamedField,
    @JS('created_at') required String createdAt,
    @JS('last_login') String? lastLogin,
    required String homepage,
    @JS('avatar_uri') String? avatarUri,
    @JS('quota_bytes') required String quotaBytes,
    @JS('session_duration') required int sessionDuration,
    @JS('idle_timeout') int? idleTimeout,
    @JS('primary_role') required String primaryRole,
    @JS('secondary_role') String? secondaryRole,
    required int priority,
    @JS('primary_child') required ChildJS primaryChild,
    @JS('optional_child') ChildJS? optionalChild,
    required JSArray<JSString> tags,
    @JS('lucky_numbers') required JSArray<JSNumber> luckyNumbers,
    required JSArray<JSString> permissions,
    required JSArray<ChildJS> children,
    required JSObject counters,
    @JS('child_by_key') required JSObject childByKey,
    @JS('epoch_timestamp') required int epochTimestamp,
    required JSObject metadata,
  });

  factory UserProfileJS.fromDart(UserProfile instance) =>
      $UserProfileToJs(instance);

  @JS('custom_id')
  external String get customId;
  @JS('first_name')
  external String get firstName;
  @JS('login_count')
  external int? get loginCount;
  external double get rating;
  external num get score;
  @JS('is_active')
  external bool get isActive;
  external String? get nickname;
  @JS('optional_count')
  external int? get optionalCount;
  external String? get tier;
  @JS('custom_name')
  external String get customNamedField;
  @JS('kebab-key')
  external String get kebabKey;
  String? get dotKey => _.getProperty<JSString?>('dot.key'.toJS)?.toDart;

  @JS('created_at')
  external String get createdAt;
  @JS('last_login')
  external String? get lastLogin;
  external String get homepage;
  @JS('avatar_uri')
  external String? get avatarUri;
  @JS('quota_bytes')
  external String get quotaBytes;
  @JS('session_duration')
  external int get sessionDuration;
  @JS('idle_timeout')
  external int? get idleTimeout;
  @JS('primary_role')
  external String get primaryRole;
  @JS('secondary_role')
  external String? get secondaryRole;
  external int? get priority;
  @JS('primary_child')
  external ChildJS get primaryChild;
  @JS('optional_child')
  external ChildJS? get optionalChild;
  external JSArray<JSString> get tags;
  @JS('lucky_numbers')
  external JSArray<JSNumber> get luckyNumbers;
  external JSArray<JSString> get permissions;
  external JSArray<ChildJS> get children;
  external JSObject get counters;
  @JS('child_by_key')
  external JSObject get childByKey;
  @JS('epoch_timestamp')
  external int get epochTimestamp;
  external JSObject get metadata;
  @JS('kebab-key')
  external set kebabKey(String value);
  set dotKey(String? value) => _.setProperty('dot.key'.toJS, value?.toJS);

  UserProfile toDart() => $UserProfileFromJs(this);
}

extension UserProfileJsCodableExtension on UserProfile {
  UserProfileJS toJs() => $UserProfileToJs(this);
}

UserProfile $UserProfileFromJs(UserProfileJS js) => UserProfile(
  customId: const CustomIdConverter().fromJson(js.customId),
  firstName: js.firstName,
  loginCount: js.loginCount ?? 0,
  rating: js.rating,
  score: js.score,
  isActive: js.isActive,
  nickname: js.nickname,
  optionalCount: js.optionalCount,
  tier: js.tier ?? 'standard',
  customNamedField: js.customNamedField,
  kebabKey: js.kebabKey,
  dotKey: js.dotKey,
  createdAt: DateTime.parse(js.createdAt),
  lastLogin: switch (js.lastLogin) {
    final v? => DateTime.parse(v),
    null => null,
  },
  homepage: Uri.parse(js.homepage),
  avatarUri: switch (js.avatarUri) {
    final v? => Uri.parse(v),
    null => null,
  },
  quotaBytes: BigInt.parse(js.quotaBytes),
  sessionDuration: Duration(microseconds: js.sessionDuration),
  idleTimeout: switch (js.idleTimeout) {
    final v? => Duration(microseconds: v),
    null => null,
  },
  primaryRole: $enumDecode(_$RoleEnumMap, js.primaryRole),
  secondaryRole: $enumDecodeNullable(_$RoleEnumMap, js.secondaryRole),
  priority:
      $enumDecodeNullable(_$PriorityEnumMap, js.priority) ?? Priority.medium,
  primaryChild: $ChildFromJs(js.primaryChild),
  optionalChild: switch (js.optionalChild) {
    final v? => $ChildFromJs(v),
    null => null,
  },
  tags: js.tags.toDart.map((e) => e.toDart).toList(),
  luckyNumbers: js.luckyNumbers.toDart.map((e) => e.toDartInt).toList(),
  permissions: js.permissions.toDart.map((e) => e.toDart).toSet(),
  children: js.children.toDart.map($ChildFromJs).toList(),
  counters: switch (js.counters) {
    final m => {
      for (final k in _$jsObjectKeys(m).toDart)
        k.toDart: m.getProperty<JSNumber>(k).toDartInt,
    },
  },
  childByKey: switch (js.childByKey) {
    final m => {
      for (final k in _$jsObjectKeys(m).toDart)
        k.toDart: $ChildFromJs(m.getProperty<ChildJS>(k)),
    },
  },
  epochTimestamp: epochMillisFromJson(js.epochTimestamp),
  metadata: const MetadataBagConverter().fromJson(
    (js.metadata.dartify() as Map).cast<String, dynamic>(),
  ),
);
UserProfileJS $UserProfileToJs(UserProfile instance) =>
    UserProfileJS(
        customId: const CustomIdConverter().toJson(instance.customId),
        firstName: instance.firstName,
        loginCount: instance.loginCount,
        rating: instance.rating,
        score: instance.score,
        isActive: instance.isActive,
        nickname: instance.nickname,
        optionalCount: instance.optionalCount,
        tier: instance.tier,
        customNamedField: instance.customNamedField,
        createdAt: instance.createdAt.toIso8601String(),
        lastLogin: instance.lastLogin?.toIso8601String(),
        homepage: instance.homepage.toString(),
        avatarUri: instance.avatarUri?.toString(),
        quotaBytes: instance.quotaBytes.toString(),
        sessionDuration: instance.sessionDuration.inMicroseconds,
        idleTimeout: instance.idleTimeout?.inMicroseconds,
        primaryRole: _$RoleEnumMap[instance.primaryRole]!,
        secondaryRole: _$RoleEnumMap[instance.secondaryRole],
        priority: _$PriorityEnumMap[instance.priority]!,
        primaryChild: $ChildToJs(instance.primaryChild),
        optionalChild: switch (instance.optionalChild) {
          final v? => $ChildToJs(v),
          null => null,
        },
        tags: instance.tags.map((e) => e.toJS).toList().toJS,
        luckyNumbers: instance.luckyNumbers.map((e) => e.toJS).toList().toJS,
        permissions: instance.permissions.map((e) => e.toJS).toList().toJS,
        children: instance.children.map($ChildToJs).toList().toJS,
        counters: (() {
          final $map = JSObject();
          for (final MapEntry(:key, :value) in instance.counters.entries) {
            $map.setProperty(key.toJS, value.toJS);
          }
          return $map;
        })(),
        childByKey: (() {
          final $map = JSObject();
          for (final MapEntry(:key, :value) in instance.childByKey.entries) {
            $map.setProperty(key.toJS, $ChildToJs(value));
          }
          return $map;
        })(),
        epochTimestamp: epochMillisToJson(instance.epochTimestamp),
        metadata:
            (const MetadataBagConverter().toJson(instance.metadata).jsify()
                as JSObject),
      )
      ..kebabKey = instance.kebabKey
      ..dotKey = instance.dotKey;
const _$RoleEnumMap = {
  Role.admin: 'admin',
  Role.member: 'member',
  Role.guest: 'guest',
};
const _$PriorityEnumMap = {
  Priority.low: 1,
  Priority.medium: 2,
  Priority.high: 3,
};
@JS('Object.keys')
external JSArray<JSString> _$jsObjectKeys(JSObject obj);
