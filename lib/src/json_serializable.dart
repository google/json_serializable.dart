// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class JsonSerializable {
  final bool createFactory;
  final bool createToJson;

  const JsonSerializable({bool createFactory: true, bool createToJson: true})
      : this.createFactory = createFactory,
        this.createToJson = createToJson;
}

/// Customizes the how an annotated field is serialized
///
/// [name] allows the key in a JSON to have a value different than the field
/// name.
class JsonKey {
  final String name;
  const JsonKey({this.name});
}
