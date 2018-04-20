// Copyright (c) 2017, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fun_class.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Fun _$FunFromJson(Map<String, dynamic> json) => new Fun(
    a: json['a'] as int,
    b: json['b'] as String,
    c: json['c'] as bool,
    innerFun: (json['innerFun'] as List)
        ?.map((e) =>
            e == null ? null : new Fun.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    dates: (json['dates'] as List)
        ?.map((e) => e == null ? null : DateTime.parse(e as String))
        ?.toList(),
    child: json['child'] == null
        ? null
        : new Fun.fromJson(json['child'] as Map<String, dynamic>));

abstract class _$FunSerializerMixin {
  int get a;
  String get b;
  bool get c;
  Fun get child;
  List<Fun> get innerFun;
  List<DateTime> get dates;
  Map<String, dynamic> toJson() {
    var val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('a', a);
    writeNotNull('b', b);
    writeNotNull('c', c);
    writeNotNull('child', child);
    writeNotNull('innerFun', innerFun);
    writeNotNull('dates', dates?.map((e) => e?.toIso8601String())?.toList());
    return val;
  }
}

// crazy goes here!
bool _$FunWriter(Object object, JsonWriter writer) {
  if (object is Fun) {
    writer.startMap();
    if (object.a != null) {
      writer.writeKeyValue('a', object.a);
    }
    if (object.b != null) {
      writer.writeKeyValue('b', object.b);
    }
    if (object.c != null) {
      writer.writeKeyValue('c', object.c);
    }
    if (object.child != null) {
      writer.writeKeyValue('child', object.child);
    }
    if (object.innerFun != null) {
      writer.writeKeyValue('innerFun', object.innerFun);
    }
    if (object.dates != null) {
      writer.writeKeyValue('dates', object.dates);
    }
    writer.endMap();
    return true;
  }
  return false;
}
