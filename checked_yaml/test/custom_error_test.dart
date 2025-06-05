import 'package:checked_yaml/checked_yaml.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  test('simple test', () {
    expect(
      () => checkedYamlDecode('{"innerMap": {}}', (m) {
        throw CheckedFromJsonException(
          m!['innerMap'] as YamlMap,
          null,
          'nothing',
          null,
        );
      }),
      throwsA(
        isA<ParsedYamlException>()
            .having(
              (e) => e.message,
              'message',
              'There was an error parsing the map.',
            )
            .having((e) => e.yamlNode, 'yamlNode', isA<YamlMap>())
            .having(
              (e) => e.innerError,
              'innerError',
              isA<CheckedFromJsonException>(),
            )
            .having((e) => e.formattedMessage, 'formattedMessage', '''
line 1, column 14: There was an error parsing the map.
  ╷
1 │ {"innerMap": {}}
  │              ^^
  ╵'''),
      ),
    );
  });

  test('null map - allowed', () {
    expect(
      () => checkedYamlDecode(allowNull: true, 'null', (m) => Object()),
      isA<Object>(),
    );
  });

  test('null map - not allowed', () {
    expect(
      () => checkedYamlDecode('null', (m) {
        throw TestFailure('should never get here!');
      }),
      throwsA(
        isA<ParsedYamlException>()
            .having((e) => e.message, 'message', 'Not a map')
            .having(
              (e) => e.yamlNode,
              'yamlNode',
              isA<YamlScalar>().having((s) => s.value, 'value', isNull),
            )
            .having((e) => e.innerError, 'innerError', isNull)
            .having((e) => e.formattedMessage, 'formattedMessage', '''
line 1, column 1: Not a map
  ╷
1 │ null
  │ ^^^^
  ╵'''),
      ),
    );
  });
}
