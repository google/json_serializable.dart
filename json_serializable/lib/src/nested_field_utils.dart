class NestedUtils {
  static List<String> getNestedJsonKeyNames(String jsonKey) {
    return jsonKey.replaceAll("'", '').split('.').map((e) => "'$e'").toList();
  }

  static String getNestedJsonKey(String jsonKey) {
    final split = jsonKey.replaceAll("'", '').split('.');
    return split.map((i) => "['$i']").toList().join();
  }

  static void makeNestedMap(Map<String, dynamic> nested, List<String> keys, String value) {
    final last = keys.last;
    keys.fold(nested, (obj, key) {
      if (last == key) {
        obj[key] = value;
        return obj;
      } else {
        obj[key] ??= <String, dynamic>{};
        return obj[key];
      }
    });
  }
}
