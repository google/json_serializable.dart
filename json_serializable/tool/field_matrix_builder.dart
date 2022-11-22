// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:build/build.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:source_helper/source_helper.dart';

import 'shared.dart';

Builder builder([_]) => _FieldMatrixBuilder();

class _FieldMatrixBuilder extends Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final output = buildStep.allowedOutputs.single;

    final content = StringBuffer('''
import 'package:json_annotation/json_annotation.dart';

part 'field_matrix.field_matrix.g.dart';
''');

    for (var isPublic in [true, false]) {
      for (var enumValue in [...FieldUsage.values, null]) {
        final className = 'Usage${(enumValue?.name).toString().pascal}'
            '${isPublic ? 'Public' : 'Private'}';

        final fieldName = isPublic ? 'field' : '_field';

        final bits = [
          if (enumValue != null) 'usage: $enumValue,',
          if (!isPublic) "name: 'field'",
        ];

        final fieldAnnotation = bits.isEmpty ? '' : '@JsonKey(${bits.join()})';

        content.writeln('''
@JsonSerializable()
class $className {
  $className();
  
  int? aField;
  
  $fieldAnnotation
  int? $fieldName;
  
  int? zField;

  factory $className.fromJson(Map<String, dynamic> json) =>
      _\$${className}FromJson(json);

  Map<String, dynamic> toJson() => _\$${className}ToJson(this);
  
  @override
  String toString() => '$className: $fieldName: \$$fieldName';
}
''');
      }
    }
    await buildStep.writeAsString(output, formatter.format(content.toString()));
  }

  @override
  Map<String, List<String>> get buildExtensions => const {
        '.dart': ['.field_matrix.dart'],
      };
}
