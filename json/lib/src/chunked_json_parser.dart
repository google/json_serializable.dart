// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

import 'package:charcode/charcode.dart';

import 'json_listener.dart';
import 'nuber_buffer.dart';

const _powersOfTen = const [
  1.0, // 0
  10.0,
  100.0,
  1000.0,
  10000.0,
  100000.0, // 5
  1000000.0,
  10000000.0,
  100000000.0,
  1000000000.0,
  10000000000.0, // 10
  100000000000.0,
  1000000000000.0,
  10000000000000.0,
  100000000000000.0,
  1000000000000000.0, // 15
  10000000000000000.0,
  100000000000000000.0,
  1000000000000000000.0,
  10000000000000000000.0,
  100000000000000000000.0, // 20
  1000000000000000000000.0,
  10000000000000000000000.0,
];

/**
 * Chunked JSON parser.
 *
 * Receives inputs in chunks, gives access to individual parts of the input,
 * and stores input state between chunks.
 *
 * Implementations include [String] and UTF-8 parsers.
 */
abstract class ChunkedJsonParser<T> {
  // A simple non-recursive state-based parser for JSON.
  //
  // Literal values accepted in states ARRAY_EMPTY, ARRAY_COMMA, OBJECT_COLON
  // and strings also in OBJECT_EMPTY, OBJECT_COMMA.
  //               VALUE  STRING  :  ,  }  ]        Transitions to
  // EMPTY            X      X                   -> END
  // ARRAY_EMPTY      X      X             @     -> ARRAY_VALUE / pop
  // ARRAY_VALUE                     @     @     -> ARRAY_COMMA / pop
  // ARRAY_COMMA      X      X                   -> ARRAY_VALUE
  // OBJECT_EMPTY            X          @        -> OBJECT_KEY / pop
  // OBJECT_KEY                   @              -> OBJECT_COLON
  // OBJECT_COLON     X      X                   -> OBJECT_VALUE
  // OBJECT_VALUE                    @  @        -> OBJECT_COMMA / pop
  // OBJECT_COMMA            X                   -> OBJECT_KEY
  // END
  // Starting a new array or object will push the current state. The "pop"
  // above means restoring this state and then marking it as an ended value.
  // X means generic handling, @ means special handling for just that
  // state - that is, values are handled generically, only punctuation
  // cares about the current state.
  // Values for states are chosen so bits 0 and 1 tell whether
  // a string/value is allowed, and setting bits 0 through 2 after a value
  // gets to the next state (not empty, doesn't allow a value).

  // State building-block constants.
  static const int TOP_LEVEL = 0;
  static const int INSIDE_ARRAY = 1;
  static const int INSIDE_OBJECT = 2;
  static const int AFTER_COLON = 3; // Always inside object.

  static const int ALLOW_STRING_MASK = 8; // Allowed if zero.
  static const int ALLOW_VALUE_MASK = 4; // Allowed if zero.
  static const int ALLOW_VALUE = 0;
  static const int STRING_ONLY = 4;
  static const int NO_VALUES = 12;

  // Objects and arrays are "empty" until their first property/element.
  // At this position, they may either have an entry or a close-bracket.
  static const int EMPTY = 0;
  static const int NON_EMPTY = 16;
  static const int EMPTY_MASK = 16; // Empty if zero.

  // Actual states               : Context | Is empty? | Next?
  static const int STATE_INITIAL = TOP_LEVEL | EMPTY | ALLOW_VALUE;
  static const int STATE_END = TOP_LEVEL | NON_EMPTY | NO_VALUES;

  static const int STATE_ARRAY_EMPTY = INSIDE_ARRAY | EMPTY | ALLOW_VALUE;
  static const int STATE_ARRAY_VALUE = INSIDE_ARRAY | NON_EMPTY | NO_VALUES;
  static const int STATE_ARRAY_COMMA = INSIDE_ARRAY | NON_EMPTY | ALLOW_VALUE;

  static const int STATE_OBJECT_EMPTY = INSIDE_OBJECT | EMPTY | STRING_ONLY;
  static const int STATE_OBJECT_KEY = INSIDE_OBJECT | NON_EMPTY | NO_VALUES;
  static const int STATE_OBJECT_COLON = AFTER_COLON | NON_EMPTY | ALLOW_VALUE;
  static const int STATE_OBJECT_VALUE = AFTER_COLON | NON_EMPTY | NO_VALUES;
  static const int STATE_OBJECT_COMMA = INSIDE_OBJECT | NON_EMPTY | STRING_ONLY;

  // Bits set in state after successfully reading a value.
  // This transitions the state to expect the next punctuation.
  static const int VALUE_READ_BITS = NON_EMPTY | NO_VALUES;

  // State of partial value at chunk split.
  static const int NO_PARTIAL = 0;
  static const int PARTIAL_STRING = 1;
  static const int PARTIAL_NUMERAL = 2;
  static const int PARTIAL_KEYWORD = 3;
  static const int MASK_PARTIAL = 3;

  // Partial states for numerals. Values can be |'ed with PARTIAL_NUMERAL.
  static const int NUM_SIGN = 0; // After initial '-'.
  static const int NUM_ZERO = 4; // After '0' as first digit.
  static const int NUM_DIGIT = 8; // After digit, no '.' or 'e' seen.
  static const int NUM_DOT = 12; // After '.'.
  static const int NUM_DOT_DIGIT = 16; // After a decimal digit (after '.').
  static const int NUM_E = 20; // After 'e' or 'E'.
  static const int NUM_E_SIGN = 24; // After '-' or '+' after 'e' or 'E'.
  static const int NUM_E_DIGIT = 28; // After exponent digit.
  static const int NUM_SUCCESS = 32; // Never stored as partial state.

  // Partial states for strings.
  static const int STR_PLAIN = 0; // Inside string, but not escape.
  static const int STR_ESCAPE = 4; // After '\'.
  static const int STR_U = 16; // After '\u' and 0-3 hex digits.
  static const int STR_U_COUNT_SHIFT = 2; // Hex digit count in bits 2-3.
  static const int STR_U_VALUE_SHIFT = 5; // Hex digit value in bits 5+.

  // Partial states for keywords.
  static const int KWD_TYPE_MASK = 12;
  static const int KWD_TYPE_SHIFT = 2;
  static const int KWD_NULL = 0; // Prefix of "null" seen.
  static const int KWD_TRUE = 4; // Prefix of "true" seen.
  static const int KWD_FALSE = 8; // Prefix of "false" seen.
  static const int KWD_COUNT_SHIFT = 4; // Prefix length in bits 4+.

  // Mask used to mask off two lower bits.
  static const int TWO_BIT_MASK = 3;

  final JsonListener _listener;

  // The current parsing state.
  int _state = STATE_INITIAL;
  final _states = <int>[];

  /**
   * Stores tokenizer state between chunks.
   *
   * This state is stored when a chunk stops in the middle of a
   * token (string, numeral, boolean or null).
   *
   * The partial state is used to continue parsing on the next chunk.
   * The previous chunk is not retained, any data needed are stored in
   * this integer, or in the [buffer] field as a string-building buffer
   * or a [NumberBuffer].
   *
   * Prefix state stored in [_state] as bits.
   *
   *            ..00 : No partial value (NO_PARTIAL).
   *
   *         ..00001 : Partial string, not inside escape.
   *         ..00101 : Partial string, after '\'.
   *     ..vvvv1dd01 : Partial \u escape.
   *                   The 'dd' bits (2-3) encode the number of hex digits seen.
   *                   Bits 5-16 encode the value of the hex digits seen so far.
   *
   *        ..0ddd10 : Partial numeral.
   *                   The `ddd` bits store the parts of in the numeral seen so
   *                   far, as the constants `NUM_*` defined above.
   *                   The characters of the numeral are stored in [buffer]
   *                   as a [_NumberBuffer].
   *
   *      ..0ddd0011 : Partial 'null' keyword.
   *      ..0ddd0111 : Partial 'true' keyword.
   *      ..0ddd1011 : Partial 'false' keyword.
   *                   For all three keywords, the `ddd` bits encode the number
   *                   of letters seen.
   */
  int _partialState = NO_PARTIAL;

  /**
   * Extra data stored while parsing a primitive value.
   * May be set during parsing, always set at chunk end if a value is partial.
   *
   * May contain a [StringBuffer] or [NumberBuffer].
   */
  Object buffer;

  ChunkedJsonParser(this._listener);

  /**
   * Push the current parse [state] on a stack.
   *
   * State is pushed when a new array or object literal starts,
   * so the parser can go back to the correct value when the literal ends.
   */
  void _saveState(int state) {
    _states.add(state);
  }

  /**
   * Restore a state pushed with [_saveState].
   */
  int _restoreState() {
    return _states.removeLast(); // Throws if empty.
  }

  /**
   * Finalizes the parsing and returns the final value.
   *
   * Throws if the source read so far doesn't end up with a complete
   * parsed value. That means it must not be inside a list or object
   * literal, and any partial value read should also be a valid complete
   * value.
   *
   * The only valid partial state is a number that ends in a digit, and
   * only if the number is the entire JSON value being parsed
   * (otherwise it would be inside a list or object).
   * Such a number will be completed. Any other partial state is an error.
   */
  Object close() {
    if (_partialState != NO_PARTIAL) {
      int partialType = _partialState & MASK_PARTIAL;
      if (partialType == PARTIAL_NUMERAL) {
        int numState = _partialState & ~MASK_PARTIAL;
        // A partial number might be a valid number if we know it's done.
        // There is an unnecessary overhead if input is a single number,
        // but this is assumed to be rare.
        NumberBuffer buffer = this.buffer;
        this.buffer = null;
        _finishChunkNumber(numState, 0, 0, buffer);
      } else if (partialType == PARTIAL_STRING) {
        throw fail(chunkEnd, "Unterminated string");
      } else {
        assert(partialType == PARTIAL_KEYWORD);
        throw fail(chunkEnd); // Incomplete literal.
      }
    }
    if (_state != STATE_END) {
      throw fail(chunkEnd);
    }
    return _listener.result;
  }

  /**
   * Length of current chunk.
   *
   * The valid arguments to [getChar] are 0 .. `chunkEnd - 1`.
   */
  int get chunkEnd => _chunkEnd;

  int _chunkEnd;

  /**
   * Returns the chunk itself.
   *
   * Only used by [fail] to include the chunk in the thrown [FormatException].
   */
  T get chunk => _chunk;

  T _chunk;

  /**
   * Get charcacter/code unit of current chunk.
   *
   * The [index] must be non-negative and less than `chunkEnd`.
   * In practive, [index] will be no smaller than the `start` argument passed
   * to [parse].
   */
  int getChar(int index);

  /**
   * Copy ASCII characters from start to end of chunk into a list.
   *
   * Used for number buffer (always copies ASCII, so encoding is not important).
   */
  void copyCharsToList(int start, int end, List<int> target, int offset);

  /**
   * Build a string using input code units.
   *
   * Creates a string buffer and enables adding characters and slices
   * to that buffer.
   * The buffer is stored in the [buffer] field. If the string is unterminated,
   * the same buffer is used to continue parsing in the next chunk.
   */
  void beginString();
  /**
   * Add single character code to string being built.
   *
   * Used for unparsed escape sequences.
   */
  void addCharToString(int charCode);

  /**
   * Adds slice of current chunk to string being built.
   *
   * The [start] positions is inclusive, [end] is exclusive.
   */
  void addSliceToString(int start, int end);

  /** Finalizes the string being built and returns it as a String. */
  String endString();

  /**
   * Extracts a literal string from a slice of the current chunk.
   *
   * No interpretation of the content is performed, except for converting
   * the source format to string.
   * This can be implemented more or less efficiently depending on the
   * underlying source.
   *
   * This is used for string literals that contain no escapes.
   *
   * The [bits] integer is an upper bound on the code point in the range
   * from `start` to `end`.
   * Usually found by doing bitwise or of all the values.
   * The function may choose to optimize depending on the value.
   */
  String getString(int start, int end, int bits);

  /**
   * Parse a slice of the current chunk as an integer.
   *
   * The format is expected to be correct.
   */
  int parseInt(int start, int end) {
    const int asciiBits = 0x7f; // Integer literals are ASCII only.
    return int.parse(getString(start, end, asciiBits));
  }

  /**
   * Parse a slice of the current chunk as a double.
   *
   * The format is expected to be correct.
   * This is used by [_parseNumber] when the double value cannot be
   * built exactly during parsing.
   */
  double parseDouble(int start, int end) {
    const int asciiBits = 0x7f; // Double literals are ASCII only.
    return double.parse(getString(start, end, asciiBits));
  }

  /**
   * Create a _NumberBuffer containing the digits from [start] to [chunkEnd].
   *
   * This creates a number buffer and initializes it with the part of the
   * number literal ending the current chunk
   */
  void createNumberBuffer(int start) {
    assert(start >= 0);
    assert(start < chunkEnd);
    int length = chunkEnd - start;
    var buffer = new NumberBuffer(length);
    copyCharsToList(start, chunkEnd, buffer.list, 0);
    buffer.length = length;
  }

  /**
   * Continues parsing a partial value.
   */
  int parsePartial(int position) {
    if (position == chunkEnd) return position;
    int partialState = _partialState;
    assert(partialState != NO_PARTIAL);
    int partialType = partialState & MASK_PARTIAL;
    _partialState = NO_PARTIAL;
    partialState = partialState & ~MASK_PARTIAL;
    assert(partialType != 0);
    if (partialType == PARTIAL_STRING) {
      position = _parsePartialString(position, partialState);
    } else if (partialType == PARTIAL_NUMERAL) {
      position = _parsePartialNumber(position, partialState);
    } else if (partialType == PARTIAL_KEYWORD) {
      position = _parsePartialKeyword(position, partialState);
    }
    return position;
  }

  /**
   * Parses the remainder of a number into the number buffer.
   *
   * Syntax is checked while pasing.
   * Starts at position, which is expected to be the start of the chunk,
   * and returns the index of the first non-number-literal character found,
   * or chunkEnd if the entire chunk is a valid number continuation.
   * Throws if a syntax error is detected.
   */
  int _parsePartialNumber(int position, int state) {
    int start = position;
    // Primitive implementation, can be optimized.
    NumberBuffer buffer = this.buffer;
    this.buffer = null;
    int end = chunkEnd;
    toBailout:
    {
      if (position == end) break toBailout;
      int char = getChar(position);
      int digit = char ^ $0;
      if (state == NUM_SIGN) {
        if (digit <= 9) {
          if (digit == 0) {
            state = NUM_ZERO;
          } else {
            state = NUM_DIGIT;
          }
          position++;
          if (position == end) break toBailout;
          char = getChar(position);
          digit = char ^ $0;
        } else {
          throw fail(position);
        }
      }
      if (state == NUM_ZERO) {
        // JSON does not allow insignificant leading zeros (e.g., "09").
        if (digit <= 9) throw fail(position);
        state = NUM_DIGIT;
      }
      while (state == NUM_DIGIT) {
        if (digit > 9) {
          if (char == $dot) {
            state = NUM_DOT;
          } else if ((char | 0x20) == $e) {
            state = NUM_E;
          } else {
            _finishChunkNumber(state, start, position, buffer);
            return position;
          }
        }
        position++;
        if (position == end) break toBailout;
        char = getChar(position);
        digit = char ^ $0;
      }
      if (state == NUM_DOT) {
        if (digit > 9) throw fail(position);
        state = NUM_DOT_DIGIT;
      }
      while (state == NUM_DOT_DIGIT) {
        if (digit > 9) {
          if ((char | 0x20) == $e) {
            state = NUM_E;
          } else {
            _finishChunkNumber(state, start, position, buffer);
            return position;
          }
        }
        position++;
        if (position == end) break toBailout;
        char = getChar(position);
        digit = char ^ $0;
      }
      if (state == NUM_E) {
        if (char == $plus || char == $minus) {
          state = NUM_E_SIGN;
          position++;
          if (position == end) break toBailout;
          char = getChar(position);
          digit = char ^ $0;
        }
      }
      assert(state >= NUM_E);
      while (digit <= 9) {
        state = NUM_E_DIGIT;
        position++;
        if (position == end) break toBailout;
        char = getChar(position);
        digit = char ^ $0;
      }
      _finishChunkNumber(state, start, position, buffer);
      return position;
    }
    // Bailout code in case the current chunk ends while parsing the numeral.
    assert(position == end);
    _continueChunkNumber(state, start, buffer);
    return chunkEnd;
  }

  /**
   * Continues parsing a partial string literal.
   *
   * Handles partial escapes and then hands the parsing off to
   * [parseStringToBuffer].
   */
  int _parsePartialString(int position, int partialState) {
    if (partialState == STR_PLAIN) {
      return parseStringToBuffer(position);
    }
    if (partialState == STR_ESCAPE) {
      position = _parseStringEscape(position);
      // parseStringEscape sets partialState if it sees the end.
      if (position == chunkEnd) return position;
      return parseStringToBuffer(position);
    }
    assert((partialState & STR_U) != 0);
    int value = partialState >> STR_U_VALUE_SHIFT;
    int count = (partialState >> STR_U_COUNT_SHIFT) & TWO_BIT_MASK;
    for (int i = count; i < 4; i++, position++) {
      if (position == chunkEnd) return chunkStringEscapeU(i, value);
      int char = getChar(position);
      int digit = _parseHexDigit(char);
      if (digit < 0) throw fail(position, "Invalid hex digit");
      value = 16 * value + digit;
    }
    addCharToString(value);
    return parseStringToBuffer(position);
  }

  /**
   * Continues parsing a partial keyword.
   */
  int _parsePartialKeyword(int position, int partialState) {
    int keywordType = partialState & KWD_TYPE_MASK;
    int count = partialState >> KWD_COUNT_SHIFT;
    int keywordTypeIndex = keywordType >> KWD_TYPE_SHIFT;
    String keyword = const ["null", "true", "false"][keywordTypeIndex];
    assert(count < keyword.length);
    do {
      if (position == chunkEnd) {
        _partialState =
            PARTIAL_KEYWORD | keywordType | (count << KWD_COUNT_SHIFT);
        return chunkEnd;
      }
      int expectedChar = keyword.codeUnitAt(count);
      if (getChar(position) != expectedChar) throw fail(position);
      position++;
      count++;
    } while (count < keyword.length);
    if (keywordType == KWD_NULL) {
      _listener.handleNull();
    } else {
      _listener.handleBool(keywordType == KWD_TRUE);
    }
    return position;
  }

  /** Convert hex-digit to its value. Returns -1 if char is not a hex digit. */
  static int _parseHexDigit(int char) {
    int digit = char ^ 0x30;
    if (digit <= 9) return digit;
    int letter = (char | 0x20) ^ 0x60;
    // values 1 .. 6 are 'a' through 'f'
    if (letter <= 6 && letter > 0) return letter + 9;
    return -1;
  }

  /**
   * Parses the current chunk as a chunk of JSON.
   *
   * Starts parsing at [position] and continues until [chunkEnd].
   * Continues parsing where the previous chunk (if any) ended.
   */
  void parse(T chunk, int position, final int end) {
    _chunk = chunk;
    _chunkEnd = end;
    if (_partialState != NO_PARTIAL) {
      position = parsePartial(position);
      if (position == end) return;
    }
    int state = _state;
    while (position < end) {
      int char = getChar(position);
      switch (char) {
        case $space:
        case $cr:
        case $lf:
        case $tab:
          position++;
          break;
        case $quote:
          if ((state & ALLOW_STRING_MASK) != 0) throw fail(position);
          state |= VALUE_READ_BITS;
          position = parseString(position + 1);
          break;
        case $lbracket:
          if ((state & ALLOW_VALUE_MASK) != 0) throw fail(position);
          _listener.beginArray();
          _saveState(state);
          state = STATE_ARRAY_EMPTY;
          position++;
          break;
        case $lbrace:
          if ((state & ALLOW_VALUE_MASK) != 0) throw fail(position);
          _listener.beginObject();
          _saveState(state);
          state = STATE_OBJECT_EMPTY;
          position++;
          break;
        case $n:
          if ((state & ALLOW_VALUE_MASK) != 0) throw fail(position);
          state |= VALUE_READ_BITS;
          position = _parseNull(position);
          break;
        case $f:
          if ((state & ALLOW_VALUE_MASK) != 0) throw fail(position);
          state |= VALUE_READ_BITS;
          position = parseFalse(position);
          break;
        case $t:
          if ((state & ALLOW_VALUE_MASK) != 0) throw fail(position);
          state |= VALUE_READ_BITS;
          position = parseTrue(position);
          break;
        case $colon:
          if (state != STATE_OBJECT_KEY) throw fail(position);
          _listener.propertyName();
          state = STATE_OBJECT_COLON;
          position++;
          break;
        case $comma:
          if (state == STATE_OBJECT_VALUE) {
            _listener.propertyValue();
            state = STATE_OBJECT_COMMA;
            position++;
          } else if (state == STATE_ARRAY_VALUE) {
            _listener.arrayElement();
            state = STATE_ARRAY_COMMA;
            position++;
          } else {
            throw fail(position);
          }
          break;
        case $rbracket:
          if (state == STATE_ARRAY_EMPTY) {
            _listener.endArray();
          } else if (state == STATE_ARRAY_VALUE) {
            _listener.arrayElement();
            _listener.endArray();
          } else {
            throw fail(position);
          }
          state = _restoreState() | VALUE_READ_BITS;
          position++;
          break;
        case $rbrace:
          if (state == STATE_OBJECT_EMPTY) {
            _listener.endObject();
          } else if (state == STATE_OBJECT_VALUE) {
            _listener.propertyValue();
            _listener.endObject();
          } else {
            throw fail(position);
          }
          state = _restoreState() | VALUE_READ_BITS;
          position++;
          break;
        default:
          if ((state & ALLOW_VALUE_MASK) != 0) throw fail(position);
          state |= VALUE_READ_BITS;
          if (char == null) print("$chunk - $position");
          position = _parseNumber(char, position);
          break;
      }
    }
    _state = state;
  }

  /**
   * Parses a "true" literal starting at [position].
   *
   * The character `source[position]` must be "t".
   */
  int parseTrue(int position) {
    assert(getChar(position) == $t);
    if (chunkEnd < position + 4) {
      return parseKeywordPrefix(position, "true", KWD_TRUE);
    }
    if (getChar(position + 1) != $r ||
        getChar(position + 2) != $u ||
        getChar(position + 3) != $e) {
      throw fail(position);
    }
    _listener.handleBool(true);
    return position + 4;
  }

  /**
   * Parses a "false" literal starting at [position].
   *
   * The character `source[position]` must be "f".
   */
  int parseFalse(int position) {
    assert(getChar(position) == $f);
    if (chunkEnd < position + 5) {
      return parseKeywordPrefix(position, "false", KWD_FALSE);
    }
    if (getChar(position + 1) != $a ||
        getChar(position + 2) != $l ||
        getChar(position + 3) != $s ||
        getChar(position + 4) != $e) {
      throw fail(position);
    }
    _listener.handleBool(false);
    return position + 5;
  }

  /**
   * Parses a "null" literal starting at [position].
   *
   * The character `source[position]` must be "n".
   */
  int _parseNull(int position) {
    assert(getChar(position) == $n);
    if (chunkEnd < position + 4) {
      return parseKeywordPrefix(position, "null", KWD_NULL);
    }
    if (getChar(position + 1) != $u ||
        getChar(position + 2) != $l ||
        getChar(position + 3) != $l) {
      throw fail(position);
    }
    _listener.handleNull();
    return position + 4;
  }

  int parseKeywordPrefix(int position, String chars, int type) {
    assert(getChar(position) == chars.codeUnitAt(0));
    int length = chunkEnd;
    int start = position;
    int count = 1;
    while (++position < length) {
      int char = getChar(position);
      if (char != chars.codeUnitAt(count)) throw fail(start);
      count++;
    }
    _partialState = PARTIAL_KEYWORD | type | (count << KWD_COUNT_SHIFT);
    return length;
  }

  /**
   * Parses a string value.
   *
   * Initial [position] is right after the initial quote.
   * Returned position right after the final quote.
   */
  int parseString(int position) {
    // Format: '"'([^\x00-\x1f\\\"]|'\\'[bfnrt/\\"])*'"'
    // Initial position is right after first '"'.
    int start = position;
    int end = chunkEnd;
    int bits = 0;
    while (position < end) {
      int char = getChar(position++);
      bits |= char; // Includes final '"', but that never matters.
      // BACKSLASH is larger than QUOTE and SPACE.
      if (char > $backslash) {
        continue;
      }
      if (char == $backslash) {
        beginString();
        int sliceEnd = position - 1;
        if (start < sliceEnd) addSliceToString(start, sliceEnd);
        return parseStringToBuffer(sliceEnd);
      }
      if (char == $quote) {
        _listener.handleString(getString(start, position - 1, bits));
        return position;
      }
      if (char < $space) {
        throw fail(position - 1, "Control character in string");
      }
    }
    beginString();
    if (start < end) addSliceToString(start, end);
    return chunkString(STR_PLAIN);
  }

  /**
   * Sets up a partial string state.
   *
   * The state is either not inside an escape, or right after a backslash.
   * For partial strings ending inside a Unicode escape, use
   * [chunkStringEscapeU].
   */
  int chunkString(int stringState) {
    _partialState = PARTIAL_STRING | stringState;
    return chunkEnd;
  }

  /**
   * Sets up a partial string state for a partially parsed Unicode escape.
   *
   * The partial string state includes the current [buffer] and the
   * number of hex digits of the Unicode seen so far (e.g., for `"\u30')
   * the state knows that two digits have been seen, and what their value is.
   *
   * Returns [chunkEnd] so it can be used as part of a return statement.
   */
  int chunkStringEscapeU(int count, int value) {
    _partialState = PARTIAL_STRING |
        STR_U |
        (count << STR_U_COUNT_SHIFT) |
        (value << STR_U_VALUE_SHIFT);
    return chunkEnd;
  }

  /**
   * Parses the remainder of a string literal into a buffer.
   *
   * The buffer is stored in [buffer] and its underlying format depends on
   * the input chunk type. For example UTF-8 decoding happens in the
   * buffer, not in the parser, since all significant JSON characters are ASCII.
   *
   * This function scans through the string literal for escapes, and copies
   * slices of non-escape characters using [addSliceToString].
   */
  int parseStringToBuffer(int position) {
    int end = chunkEnd;
    int start = position;
    while (true) {
      if (position == end) {
        if (position > start) {
          addSliceToString(start, position);
        }
        return chunkString(STR_PLAIN);
      }
      int char = getChar(position++);
      if (char > $backslash) continue;
      if (char < $space) {
        throw fail(position - 1); // Control character in string.
      }
      if (char == $quote) {
        int quotePosition = position - 1;
        if (quotePosition > start) {
          addSliceToString(start, quotePosition);
        }
        _listener.handleString(endString());
        return position;
      }
      if (char != $backslash) {
        continue;
      }
      // Handle escape.
      if (position - 1 > start) {
        addSliceToString(start, position - 1);
      }
      if (position == end) return chunkString(STR_ESCAPE);
      position = _parseStringEscape(position);
      if (position == end) return position;
      start = position;
    }
  }

  /**
   * Parse a string escape.
   *
   * Position is right after the initial backslash.
   * The following escape is parsed into a character code which is added to
   * the current string buffer using [addCharToString].
   *
   * Returns position after the last character of the escape.
   */
  int _parseStringEscape(int position) {
    int char = getChar(position++);
    int length = chunkEnd;
    switch (char) {
      case $b:
        char = $bs;
        break;
      case $f:
        char = $ff;
        break;
      case $n:
        char = $lf;
        break;
      case $r:
        char = $cr;
        break;
      case $t:
        char = $tab;
        break;
      case $slash:
      case $backslash:
      case $quote:
        break;
      case $u:
        int hexStart = position - 1;
        int value = 0;
        for (int i = 0; i < 4; i++) {
          if (position == length) return chunkStringEscapeU(i, value);
          char = getChar(position++);
          int digit = char ^ 0x30;
          value *= 16;
          if (digit <= 9) {
            value += digit;
          } else {
            digit = (char | 0x20) - $a;
            if (digit < 0 || digit > 5) {
              throw fail(hexStart, "Invalid unicode escape");
            }
            value += digit + 10;
          }
        }
        char = value;
        break;
      default:
        if (char < $space) throw fail(position, "Control character in string");
        throw fail(position, "Unrecognized string escape");
    }
    addCharToString(char);
    if (position == length) return chunkString(STR_PLAIN);
    return position;
  }

  /// Sets up a partial numeral state.
  /// Returns chunkEnd to allow easy one-line bailout tests.
  int _beginChunkNumber(int state, int start) {
    int end = chunkEnd;
    int length = end - start;
    var buffer = new NumberBuffer(length);
    copyCharsToList(start, end, buffer.list, 0);
    buffer.length = length;
    this.buffer = buffer;
    _partialState = PARTIAL_NUMERAL | state;
    return end;
  }

  void _addNumberChunk(NumberBuffer buffer, int start, int end, int overhead) {
    int length = end - start;
    int count = buffer.length;
    int newCount = count + length;
    int newCapacity = newCount + overhead;
    buffer.ensureCapacity(newCapacity);
    copyCharsToList(start, end, buffer.list, count);
    buffer.length = newCount;
  }

  // Continues an already chunked number across an entire chunk.
  int _continueChunkNumber(int state, int start, NumberBuffer buffer) {
    int end = chunkEnd;
    _addNumberChunk(buffer, start, end, NumberBuffer.kDefaultOverhead);
    this.buffer = buffer;
    _partialState = PARTIAL_NUMERAL | state;
    return end;
  }

  int _finishChunkNumber(int state, int start, int end, NumberBuffer buffer) {
    if (state == NUM_ZERO) {
      _listener.handleNumber(0);
      return end;
    }
    if (end > start) {
      _addNumberChunk(buffer, start, end, 0);
    }
    if (state == NUM_DIGIT) {
      _listener.handleNumber(buffer.parseInt());
    } else if (state == NUM_DOT_DIGIT || state == NUM_E_DIGIT) {
      _listener.handleNumber(buffer.parseDouble());
    } else {
      throw fail(chunkEnd, "Unterminated number literal");
    }
    return end;
  }

  int _parseNumber(int char, int position) {
    // Also called on any unexpected character.
    // Format:
    //  '-'?('0'|[1-9][0-9]*)('.'[0-9]+)?([eE][+-]?[0-9]+)?
    int start = position;
    int length = chunkEnd;
    // Collects an int value while parsing. Used for both an integer literal,
    // an the exponent part of a double literal.
    int intValue = 0;
    double doubleValue = 0.0; // Collect double value while parsing.
    int sign = 1;
    bool isDouble = false;
    // Break this block when the end of the number literal is reached.
    // At that time, position points to the next character, and isDouble
    // is set if the literal contains a decimal point or an exponential.
    if (char == $minus) {
      sign = -1;
      position++;
      if (position == length) return _beginChunkNumber(NUM_SIGN, start);
      char = getChar(position);
    }
    int digit = char ^ $0;
    if (digit > 9) {
      if (sign < 0) {
        throw fail(position, "Missing expected digit");
      } else {
        // If it doesn't even start out as a numeral.
        throw fail(position, "Unexpected character");
      }
    }
    if (digit == 0) {
      position++;
      if (position == length) return _beginChunkNumber(NUM_ZERO, start);
      char = getChar(position);
      digit = char ^ $0;
      // If starting with zero, next character must not be digit.
      if (digit <= 9) throw fail(position);
    } else {
      do {
        intValue = 10 * intValue + digit;
        position++;
        if (position == length) return _beginChunkNumber(NUM_DIGIT, start);
        char = getChar(position);
        digit = char ^ $0;
      } while (digit <= 9);
    }
    if (char == $dot) {
      isDouble = true;
      doubleValue = intValue.toDouble();
      intValue = 0;
      position++;
      if (position == length) return _beginChunkNumber(NUM_DOT, start);
      char = getChar(position);
      digit = char ^ $0;
      if (digit > 9) throw fail(position);
      do {
        doubleValue = 10.0 * doubleValue + digit;
        intValue -= 1;
        position++;
        if (position == length) return _beginChunkNumber(NUM_DOT_DIGIT, start);
        char = getChar(position);
        digit = char ^ $0;
      } while (digit <= 9);
    }
    if ((char | 0x20) == $e) {
      if (!isDouble) {
        doubleValue = intValue.toDouble();
        intValue = 0;
        isDouble = true;
      }
      position++;
      if (position == length) return _beginChunkNumber(NUM_E, start);
      char = getChar(position);
      int expSign = 1;
      int exponent = 0;
      if (char == $plus || char == $minus) {
        expSign = 0x2C - char; // -1 for MINUS, +1 for PLUS
        position++;
        if (position == length) return _beginChunkNumber(NUM_E_SIGN, start);
        char = getChar(position);
      }
      digit = char ^ $0;
      if (digit > 9) {
        throw fail(position, "Missing expected digit");
      }
      do {
        exponent = 10 * exponent + digit;
        position++;
        if (position == length) return _beginChunkNumber(NUM_E_DIGIT, start);
        char = getChar(position);
        digit = char ^ $0;
      } while (digit <= 9);
      intValue += expSign * exponent;
    }
    if (!isDouble) {
      _listener.handleNumber(sign * intValue);
      return position;
    }
    // Double values at or above this value (2 ** 53) may have lost precission.
    // Only trust results that are below this value.
    const double maxExactDouble = 9007199254740992.0;
    if (doubleValue < maxExactDouble) {
      int exponent = intValue;
      double signedMantissa = doubleValue * sign;
      if (exponent >= -22) {
        if (exponent < 0) {
          _listener.handleNumber(signedMantissa / _powersOfTen[-exponent]);
          return position;
        }
        if (exponent == 0) {
          _listener.handleNumber(signedMantissa);
          return position;
        }
        if (exponent <= 22) {
          _listener.handleNumber(signedMantissa * _powersOfTen[exponent]);
          return position;
        }
      }
    }
    // If the value is outside the range +/-maxExactDouble or
    // exponent is outside the range +/-22, then we can't trust simple double
    // arithmetic to get the exact result, so we use the system double parsing.
    _listener.handleNumber(parseDouble(start, position));
    return position;
  }

  FormatException fail(int position, [String message]) {
    if (message == null) {
      message = "Unexpected character";
      if (position == chunkEnd) message = "Unexpected end of input";
    }
    return new FormatException(message, chunk, position);
  }
}
