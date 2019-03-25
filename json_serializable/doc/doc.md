# fields

<dl>
  <dt><code>anyMap</code></dt>
  <dd>
     Support classes: <code>JsonSerializable</code><br>
     If <code>true</code>, <code>Map</code> types are *not* assumed to be <code>Map&lt;String, dynamic&gt;</code> – which is the default type of <code>Map</code> instances return by JSON decode in <code>dart:convert</code>.
  </dd>
  <dt><code>checked</code></dt>
  <dd>
     Support classes: <code>JsonSerializable</code><br>
     If <code>true</code>, generated <code>fromJson</code> functions include extra checks to validate proper deserialization of types.
  </dd>
  <dt><code>createFactory</code></dt>
  <dd>
     Support classes: <code>JsonSerializable</code><br>
     If <code>true</code>, a private, static <code>_$ExampleFromJson</code> method is created in the generated part file.
  </dd>
  <dt><code>createToJson</code></dt>
  <dd>
     Support classes: <code>JsonSerializable</code><br>
     If <code>true</code>, code for encoding JSON is generated for this class.
  </dd>
  <dt><code>defaultValue</code></dt>
  <dd>
     Support classes: <code>JsonKey</code><br>
     The value to use if the source JSON does not contain this key or if the value is <code>null</code>.
  </dd>
  <dt><code>disallowNullValue</code></dt>
  <dd>
     Support classes: <code>JsonKey</code><br>
     If <code>true</code>, generated code will throw a <code>DisallowedNullValueException</code> if the corresponding key exits, but the value is <code>null</code>.
  </dd>
  <dt><code>disallowUnrecognizedKeys</code></dt>
  <dd>
     Support classes: <code>JsonSerializable</code><br>
     If <code>false</code>, then any unrecognized keys passed to the generated FromJson factory will be ignored.
  </dd>
  <dt><code>encodeEmptyCollection</code></dt>
  <dd>
     Support classes: <code>JsonSerializable</code>, <code>JsonKey</code><br>
     Whether the generator should include the annotated field value in the serialized output if it is empty.
  </dd>
  <dt><code>explicitToJson</code></dt>
  <dd>
     Support classes: <code>JsonSerializable</code><br>
     If <code>true</code>, generated <code>toJson</code> methods will explicitly call <code>toJson</code> on nested objects.
  </dd>
  <dt><code>fieldRename</code></dt>
  <dd>
     Support classes: <code>JsonSerializable</code><br>
     Defines the automatic naming strategy when converting class field names into JSON map keys.
  </dd>
  <dt><code>fromJson</code></dt>
  <dd>
     Support classes: <code>JsonKey</code><br>
     A top-level <code>Function</code> to use when deserializing the associated JSON value to the annotated field.
  </dd>
  <dt><code>generateToJsonFunction</code></dt>
  <dd>
     Support classes: <code>JsonSerializable</code><br>
     Controls how <code>toJson</code> functionality is generated for all types processed by this generator.
  </dd>
  <dt><code>ignore</code></dt>
  <dd>
     Support classes: <code>JsonKey</code><br>
     <code>true</code> if the generator should ignore this field completely.
  </dd>
  <dt><code>includeIfNull</code></dt>
  <dd>
     Support classes: <code>JsonSerializable</code>, <code>JsonKey</code><br>
     Whether the generator should include fields with <code>null</code> values in the serialized output.
  </dd>
  <dt><code>name</code></dt>
  <dd>
     Support classes: <code>JsonKey</code><br>
     The key in a JSON map to use when reading and writing values corresponding to the annotated fields.
  </dd>
  <dt><code>nullable</code></dt>
  <dd>
     Support classes: <code>JsonSerializable</code>, <code>JsonKey</code><br>
     When <code>true</code>, <code>null</code> values are handled gracefully when serializing to JSON and when deserializing <code>null</code> and nonexistent values from a JSON map.
  </dd>
  <dt><code>required</code></dt>
  <dd>
     Support classes: <code>JsonKey</code><br>
     When <code>true</code>, generated code for <code>fromJson</code> will verify that the source JSON map contains the associated key.
  </dd>
  <dt><code>toJson</code></dt>
  <dd>
     Support classes: <code>JsonKey</code><br>
     A top-level <code>Function</code> to use when serializing the annotated field to JSON.
  </dd>
  <dt><code>useWrappers</code></dt>
  <dd>
     Support classes: <code>JsonSerializable</code><br>
     If <code>true</code>, wrappers are used to minimize the number of <code>Map</code> and <code>List</code> instances created during serialization.
  </dd>
</dl>
