/// provides control over how runtime overrides
/// affect serialization/deserialization
/// [none] - the default generated action is applied
/// [off] - the default action is ignored and the feature is forced [off].
enum JsonOverride { none, off }

///
/// A collection of overrides that can be individually enabled.
///
/// The overrides allow you to change the deserialisation/serialization
/// behaviour at run time.
///
/// An example usage would be to generate code with the [allowedKeys]
/// option disabled which assists in a debug environment but then
/// remove the rule for production.
///
/// If and override isn't set then [JsonOverride.none] is
/// applied and the default generation rules apply.
class JsonOverrides {
  static JsonOverrides _global = JsonOverrides._internal();

  JsonOverride allowedKeys;
  JsonOverride requiredKeys;
  JsonOverride disallowNullValues;

  /// Passed to the toJson/fromJson
  /// methods to override settings for individual types.
  /// If passed these settings override the global settings
  /// and the generated settings.
  JsonOverrides({this.allowedKeys, this.requiredKeys, this.disallowNullValues});

  ///
  ///[global] allows you to set the default overrides
  ///which will be applied to all calls to [toJson/fromJson]
  ///unless an individual [override] has been pass to those
  ///methods.
  static set global(JsonOverrides global) {
    _global = JsonOverrides.from(global);
  }

  ///
  ///Set the default global overrides to [JsonOverride.none]
  JsonOverrides._internal(
      {this.allowedKeys = JsonOverride.none,
      this.requiredKeys = JsonOverride.none,
      this.disallowNullValues = JsonOverride.none});

  JsonOverrides.from(JsonOverrides overrides)
      : allowedKeys = overrides.allowedKeys,
        requiredKeys = overrides.requiredKeys,
        disallowNullValues = overrides.disallowNullValues;

  ///
  /// Takes a [local] set of [JsonOverrides] (pass to toJson/fromJson)
  /// and combines them with the global settings to
  /// generate a resolved set of overrides.
  /// This calls is responsibe for defining the precedence
  /// of overrides.
  static JsonOverrides resolveOverrides(JsonOverrides local) {
    final resolved = JsonOverrides.from(_global);

    if (local != null) {
      if (local.allowedKeys == JsonOverride.off) {
        resolved.allowedKeys = JsonOverride.off;
      }

      if (local.requiredKeys == JsonOverride.off) {
        resolved.requiredKeys = JsonOverride.off;
      }

      if (local.disallowNullValues == JsonOverride.off) {
        resolved.disallowNullValues = JsonOverride.off;
      }
    }
    return resolved;
  }
}
