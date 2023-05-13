// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';
import 'package:source_helper/source_helper.dart';

import '../default_container.dart';
import '../type_helper.dart';
import 'to_from_string.dart';

class BigIntHelper extends TypeHelper {
  const BigIntHelper();

  @override
  String? serialize(
    DartType targetType,
    String expression,
    TypeHelperContext context,
  ) =>
      bigIntString.serialize(
        targetType,
        expression,
        targetType.isNullableType,
      );

  @override
  DefaultContainer? deserialize(
    DartType targetType,
    String expression,
    TypeHelperContext context,
    bool defaultProvided,
  ) =>
      bigIntString.deserialize(
        targetType,
        expression,
        targetType.isNullableType,
        false,
      );
}
