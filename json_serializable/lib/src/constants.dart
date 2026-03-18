// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Name used for closure argument when generating calls to `map`.
const closureArg = 'e';

const generatedLocalVarName = 'value';

const converterOrKeyInstructions = r'''
* Use `JsonConverter`
  https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonConverter-class.html
* Use `JsonKey` fields `fromJson` and `toJson`
  https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonKey/fromJson.html
  https://pub.dev/documentation/json_annotation/latest/json_annotation/JsonKey/toJson.html''';

/// This package generates code that uses null-aware elements, which were
/// introduced in Dart 3.8.
const supportedLanguageConstraint = '^3.8.0';
