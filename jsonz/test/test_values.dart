// ignore_for_file: slash_for_doc_comments,prefer_single_quotes

List get testValues => [
      [5, '5'],
      [-42, '-42'],
      [3.14, '3.14'],
      [true, 'true'],
      [false, 'false'],
      [null, 'null'],
      ['quote"or\'', '"quote\\"or\'"'],
      ['', '""'],
      [[], "[]"],
      [
        [3, -4.5, true, "hi", false],
        '[3,-4.5,true,"hi",false]'
      ],
      [
        [null],
        "[null]"
      ],
      [
        [
          [null]
        ],
        "[[null]]"
      ],
      [
        [
          [3]
        ],
        "[[3]]"
      ],
      [{}, "{}"],
      [
        {"x": 3, "y": 4.5, "z": "hi", "u": true, "v": false},
        '{"x":3,"y":4.5,"z":"hi","u":true,"v":false}'
      ],
      [
        {"x": null},
        '{"x":null}'
      ],
      [
        {"x": {}},
        '{"x":{}}'
      ],
      // Note that -0.0 won't be treated the same in JS. The Json spec seems to
      // allow it, though.
      [
        {"hi there": 499, "'": -0.0},
        '{"hi there":499,"\'":-0.0}'
      ],
      [r'\foo', r'"\\foo"'],
    ];
