typedef bool WriteJson(Object source, JsonWriter writer);

abstract class JsonWriter {
  void writeObject(Object object);

  void startMap();
  void writeKeyValue(String key, Object value);
  void endMap();

  void startList();
  void writeListValue(Object value);
  void endList();
}
