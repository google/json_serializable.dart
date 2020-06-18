import './helper_core.dart';

abstract class ExtensionHelper implements HelperCore {
  Iterable<String> createExtension() sync* {
    assert(config.createExtension);
    final buffer = StringBuffer()
      ..writeln('extension $extensionName on $className { '
          'static $className fromJson(Map<String, dynamic> json) => ${prefix}FromJson(json); '
          'Map<String, dynamic> toJson() => ${prefix}ToJson(this); '
          '}');

    yield buffer.toString();
  }

  String get className => element.name;

  String get extensionName => '$className${config.extensionSuffix}';
}
