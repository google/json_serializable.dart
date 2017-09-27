// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library json_serializable.example;

import 'package:json_annotation/json_annotation.dart';
part 'json_literal.g.dart';

@JsonLiteral('data.json')
List get data => _$dataJsonLiteral;

@JsonLiteral('data.json', asConst: true)
List get asConst => _$asConstJsonLiteral;
