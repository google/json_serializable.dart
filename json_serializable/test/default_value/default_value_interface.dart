// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

abstract class DefaultValue {
  bool fieldBool;
  String fieldString;
  int fieldInt;
  double fieldDouble;
  List fieldListEmpty;
  Map fieldMapEmpty;
  List<int> fieldListSimple;
  Map<String, int> fieldMapSimple;
  Map<String, List<String>> fieldMapListString;
  Greek fieldEnum;
}

enum Greek { alpha, beta, gamma, delta }
