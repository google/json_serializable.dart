// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:mirrors';

import 'package:path/path.dart' as p;
import 'package:source_gen/source_gen.dart';
import 'package:test/test.dart';

String _packagePathCache;

String getPackagePath() {
  if (_packagePathCache == null) {
    // Getting the location of this file – via reflection
    var currentFilePath = (reflect(getPackagePath) as ClosureMirror)
        .function
        .location
        .sourceUri
        .path;

    _packagePathCache = p.normalize(p.join(p.dirname(currentFilePath), '..'));
  }
  return _packagePathCache;
}

Matcher throwsInvalidGenerationSourceError(messageMatcher, todoMatcher) =>
    throwsA(allOf(
        const isInstanceOf<InvalidGenerationSourceError>(),
        new FeatureMatcher<InvalidGenerationSourceError>(
            'message', (e) => e.message, messageMatcher),
        new FeatureMatcher<InvalidGenerationSourceError>(
            'todo', (e) => e.todo, todoMatcher),
        new FeatureMatcher<InvalidGenerationSourceError>(
            'element', (e) => e.element, isNotNull)));

// TODO(kevmoo) add this to pkg/matcher – is nice!
class FeatureMatcher<T> extends CustomMatcher {
  final dynamic Function(T value) _feature;

  FeatureMatcher(String name, this._feature, matcher)
      : super('`$name`', '`$name`', matcher);

  @override
  featureValueOf(covariant T actual) => _feature(actual);
}

void roundTripObject<T>(T object, T factory(Map<String, dynamic> json)) {
  var data = loudEncode(object);

  var person2 = factory(json.decode(data) as Map<String, dynamic>);

  expect(person2, equals(object));

  var json2 = loudEncode(person2);

  expect(json2, equals(data));
}

/// Prints out nested causes before throwing `JsonUnsupportedObjectError`.
String loudEncode(Object object) {
  try {
    return const JsonEncoder.withIndent(' ').convert(object);
  } on JsonUnsupportedObjectError catch (e) {
    var error = e;
    do {
      var cause = error.cause;
      print(cause);
      error = (cause is JsonUnsupportedObjectError) ? cause : null;
    } while (error != null);
    rethrow;
  }
}
