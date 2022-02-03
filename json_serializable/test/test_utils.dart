// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:test/test.dart';

export 'package:_json_serial_shared_test/shared_test.dart';

final throwsTypeError = throwsA(isTypeError);

final isTypeError = isA<TypeError>();

bool deepEquals(dynamic a, dynamic b) =>
    const DeepCollectionEquality().equals(a, b);
