typedef bool WriteJson(Object source, JsonWriter writer);

abstract class JsonWriter {
  void startMap();
  void writeKeyValue(String key, Object value);
  void endMap();
}
