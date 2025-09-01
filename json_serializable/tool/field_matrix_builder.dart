// Copyright (c) 2019, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:build/build.dart';
import 'package:path/path.dart' as p;
import 'package:source_helper/source_helper.dart';

import 'shared.dart';

Builder builder([_]) => _FieldMatrixBuilder();

class _FieldMatrixBuilder extends Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final inputBaseName = p.basenameWithoutExtension(buildStep.inputId.path);

    final output = buildStep.allowedOutputs.single;

    final content = StringBuffer('''
import 'package:json_annotation/json_annotation.dart';

part '$inputBaseName.field_matrix.g.dart';
''');

    final classes = <String>{};

    for (var isPublic in [true, false]) {
      for (var includeToJson in [null, true, false]) {
        for (var includeFromJson in [null, true, false]) {
          final className = 'ToJson${includeToJson.toString().pascal}'
              'FromJson${includeFromJson.toString().pascal}'
              '${isPublic ? 'Public' : 'Private'}';

          classes.add(className);

          final fieldName = isPublic ? 'field' : '_field';

          final bits = [
            if (includeFromJson != null) 'includeFromJson: $includeFromJson,',
            if (includeToJson != null) 'includeToJson: $includeToJson,',
            if (!isPublic) "name: 'field'",
          ];

          final fieldAnnotation =
              bits.isEmpty ? '' : '@JsonKey(${bits.join()})';

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
    }

    content.writeln('''
const fromJsonFactories = <Object Function(Map<String, dynamic>)>{
  ${classes.map((e) => '$e.fromJson,').join()}
};
''');

    await buildStep.writeAsString(output, formatter.format(content.toString()));
  }

  @override
  Map<String, List<String>> get buildExtensions => const {
        '.dart': ['.field_matrix.dart'],
      };
}
