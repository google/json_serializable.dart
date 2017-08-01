import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:path/path.dart' as p;

import 'test_files/json_literal.dart';
import 'test_utils.dart';

main() {
  test('literal round-trip', () {
    var dataFilePath =
        p.join(getPackagePath(), 'test', 'test_files', 'data.json');
    var dataFile = new File(dataFilePath);

    var dataString = loudEncode(JSON.decode(dataFile.readAsStringSync()));
    // FYI: nice to re-write the test data when it's changed to keep it pretty
    // ... but not a good idea to ship this
    // dataFile.writeAsStringSync(dataString);
    var dartString = loudEncode(data);

    expect(dartString, dataString);
  });
}
