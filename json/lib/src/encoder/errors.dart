// ignore_for_file: slash_for_doc_comments, annotate_overrides, prefer_single_quotes

// For doc comments
import '../my_json_codec.dart';
import 'json_encoder.dart' show JsonEncoder;

/**
 * Error thrown by JSON serialization if an object cannot be serialized.
 *
 * The [unsupportedObject] field holds that object that failed to be serialized.
 *
 * If an object isn't directly serializable, the serializer calls the `toJson`
 * method on the object. If that call fails, the error will be stored in the
 * [cause] field. If the call returns an object that isn't directly
 * serializable, the [cause] is null.
 */
class JsonUnsupportedObjectError extends Error {
  /// The object that could not be serialized.
  final Object unsupportedObject;

  /// The exception thrown when trying to convert the object.
  final Object cause;

  /// The partial result of the conversion, up until the error happened.
  ///
  /// May be null.
  final String partialResult;

  JsonUnsupportedObjectError(this.unsupportedObject,
      {this.cause, this.partialResult});

  String toString() {
    String safeString = Error.safeToString(unsupportedObject);
    String prefix;
    if (cause != null) {
      prefix = "Converting object to an encodable object failed:";
    } else {
      prefix = "Converting object did not return an encodable object:";
    }
    return "$prefix $safeString";
  }
}

/**
 * Reports that an object could not be stringified due to cyclic references.
 *
 * An object that references itself cannot be serialized by
 * [MyJsonCodec.encode]/[JsonEncoder.convert].
 * When the cycle is detected, a [JsonCyclicError] is thrown.
 */
class JsonCyclicError extends JsonUnsupportedObjectError {
  /** The first object that was detected as part of a cycle. */
  JsonCyclicError(Object object) : super(object);
  String toString() => "Cyclic error in JSON stringify";
}
