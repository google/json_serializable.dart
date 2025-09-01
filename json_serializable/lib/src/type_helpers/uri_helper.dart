// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/element/type.dart';
import 'package:source_helper/source_helper.dart';

import '../default_container.dart';
import '../type_helper.dart';
import 'to_from_string.dart';

class UriHelper extends TypeHelper {
  const UriHelper();

  @override
  String? serialize(
    DartType targetType,
    String expression,
    TypeHelperContext context,
  ) =>
      uriString.serialize(
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
      uriString.deserialize(
          targetType, expression, targetType.isNullableType, false);
}
