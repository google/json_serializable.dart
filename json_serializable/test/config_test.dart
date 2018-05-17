// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:build/build.dart';
import 'package:json_serializable/builder.dart';
import 'package:logging/logging.dart';
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

final _throwsCastError = throwsA(const isInstanceOf<CastError>());

void main() {
  StreamSubscription sub;
  final records = <LogRecord>[];

  setUpAll(() {
    sub = log.onRecord.listen(records.add);
  });

  tearDownAll(() async {
    await sub.cancel();
  });

  setUp(records.clear);

  test('empty', () async {
    var builder = jsonSerializable(BuilderOptions.empty) as PartBuilder;
    expect(builder, isNotNull);
    expect(records, isEmpty);
  });

  test('valid config', () async {
    var builder =
        jsonSerializable(const BuilderOptions(_validConfig)) as PartBuilder;
    expect(builder, isNotNull);

    expect(records, isEmpty);
  });

  test('unsupported configuration', () async {
    var builder =
        jsonSerializable(const BuilderOptions(const {'unsupported': 'config'}))
            as PartBuilder;
    expect(builder, isNotNull);

    expect(records.single.message,
        'These options were ignored: `{unsupported: config}`.');
  });

  group('invalid config', () {
    for (var entry in _invalidConfig.entries) {
      test(entry.key, () {
        var config = new Map<String, dynamic>.from(_validConfig);
        config[entry.key] = entry.value;

        expect(() => jsonSerializable(new BuilderOptions(config)),
            _throwsCastError);
      });
    }
  });
}

const _validConfig = const {
  'header': 'header',
  'use_wrappers': true,
  'any_map': true,
  'checked': true
};

const _invalidConfig = const {
  'header': true,
  'use_wrappers': 42,
  'any_map': 42,
  'checked': 42
};
