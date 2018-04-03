// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';
part 'json_literal.g.dart';

@JsonLiteral('json_literal.json')
List get data => _$dataJsonLiteral;

@JsonLiteral('json_literal.json', asConst: true)
List get asConst => _$asConstJsonLiteral;
