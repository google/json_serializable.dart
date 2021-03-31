// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

abstract class DefaultValue {
  bool get fieldBool;

  String get fieldString;

  int get fieldInt;

  double get fieldDouble;

  List get fieldListEmpty;

  Map get fieldMapEmpty;

  Set get fieldSetEmpty;

  List<int> get fieldListSimple;

  Set<String> get fieldSetSimple;

  Map<String, int> get fieldMapSimple;

  Map<String, List<String>> get fieldMapListString;

  Greek get fieldEnum;
}

enum Greek { alpha, beta, gamma, delta }
