// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: lines_longer_than_80_chars, text_direction_code_point_in_literal, inference_failure_on_function_invocation, inference_failure_on_collection_literal

part of 'input.type_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleClass _$SimpleClassFromJson(Map<String, dynamic> json) => SimpleClass(
      (),
    );

Map<String, dynamic> _$SimpleClassToJson(SimpleClass instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{},
    };

SimpleClassNullable _$SimpleClassNullableFromJson(Map<String, dynamic> json) =>
    SimpleClassNullable(
      (),
    );

Map<String, dynamic> _$SimpleClassNullableToJson(
        SimpleClassNullable instance) =>
    <String, dynamic>{
      'value': instance.value == null ? null : <String, dynamic>{},
    };

SimpleClassOfBigInt _$SimpleClassOfBigIntFromJson(Map<String, dynamic> json) =>
    SimpleClassOfBigInt(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          BigInt.parse($jsonValue[r'$1'] as String),
          named: BigInt.parse($jsonValue['named'] as String),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfBigIntToJson(
        SimpleClassOfBigInt instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1.toString(),
        'named': instance.value.named.toString(),
      },
    };

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);

SimpleClassNullableOfBigInt _$SimpleClassNullableOfBigIntFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfBigInt(
      _$recordConvertNullable(
        json['value'],
        ($jsonValue) => (
          BigInt.parse($jsonValue[r'$1'] as String),
          named: BigInt.parse($jsonValue['named'] as String),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassNullableOfBigIntToJson(
        SimpleClassNullableOfBigInt instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1.toString(),
              'named': instance.value!.named.toString(),
            },
    };

$Rec? _$recordConvertNullable<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    value == null ? null : convert(value as Map<String, dynamic>);

SimpleClassOfBigIntNullable _$SimpleClassOfBigIntNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfBigIntNullable(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          $jsonValue[r'$1'] == null
              ? null
              : BigInt.parse($jsonValue[r'$1'] as String),
          named: $jsonValue['named'] == null
              ? null
              : BigInt.parse($jsonValue['named'] as String),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfBigIntNullableToJson(
        SimpleClassOfBigIntNullable instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1?.toString(),
        'named': instance.value.named?.toString(),
      },
    };

SimpleClassNullableOfBigIntNullable
    _$SimpleClassNullableOfBigIntNullableFromJson(Map<String, dynamic> json) =>
        SimpleClassNullableOfBigIntNullable(
          _$recordConvertNullable(
            json['value'],
            ($jsonValue) => (
              $jsonValue[r'$1'] == null
                  ? null
                  : BigInt.parse($jsonValue[r'$1'] as String),
              named: $jsonValue['named'] == null
                  ? null
                  : BigInt.parse($jsonValue['named'] as String),
            ),
          ),
        );

Map<String, dynamic> _$SimpleClassNullableOfBigIntNullableToJson(
        SimpleClassNullableOfBigIntNullable instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1?.toString(),
              'named': instance.value!.named?.toString(),
            },
    };

SimpleClassOfBool _$SimpleClassOfBoolFromJson(Map<String, dynamic> json) =>
    SimpleClassOfBool(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          $jsonValue[r'$1'] as bool,
          named: $jsonValue['named'] as bool,
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfBoolToJson(SimpleClassOfBool instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1,
        'named': instance.value.named,
      },
    };

SimpleClassNullableOfBool _$SimpleClassNullableOfBoolFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfBool(
      _$recordConvertNullable(
        json['value'],
        ($jsonValue) => (
          $jsonValue[r'$1'] as bool,
          named: $jsonValue['named'] as bool,
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassNullableOfBoolToJson(
        SimpleClassNullableOfBool instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1,
              'named': instance.value!.named,
            },
    };

SimpleClassOfBoolNullable _$SimpleClassOfBoolNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfBoolNullable(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          $jsonValue[r'$1'] as bool?,
          named: $jsonValue['named'] as bool?,
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfBoolNullableToJson(
        SimpleClassOfBoolNullable instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1,
        'named': instance.value.named,
      },
    };

SimpleClassNullableOfBoolNullable _$SimpleClassNullableOfBoolNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfBoolNullable(
      _$recordConvertNullable(
        json['value'],
        ($jsonValue) => (
          $jsonValue[r'$1'] as bool?,
          named: $jsonValue['named'] as bool?,
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassNullableOfBoolNullableToJson(
        SimpleClassNullableOfBoolNullable instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1,
              'named': instance.value!.named,
            },
    };

SimpleClassOfDateTime _$SimpleClassOfDateTimeFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfDateTime(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          DateTime.parse($jsonValue[r'$1'] as String),
          named: DateTime.parse($jsonValue['named'] as String),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfDateTimeToJson(
        SimpleClassOfDateTime instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1.toIso8601String(),
        'named': instance.value.named.toIso8601String(),
      },
    };

SimpleClassNullableOfDateTime _$SimpleClassNullableOfDateTimeFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfDateTime(
      _$recordConvertNullable(
        json['value'],
        ($jsonValue) => (
          DateTime.parse($jsonValue[r'$1'] as String),
          named: DateTime.parse($jsonValue['named'] as String),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassNullableOfDateTimeToJson(
        SimpleClassNullableOfDateTime instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1.toIso8601String(),
              'named': instance.value!.named.toIso8601String(),
            },
    };

SimpleClassOfDateTimeNullable _$SimpleClassOfDateTimeNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfDateTimeNullable(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          $jsonValue[r'$1'] == null
              ? null
              : DateTime.parse($jsonValue[r'$1'] as String),
          named: $jsonValue['named'] == null
              ? null
              : DateTime.parse($jsonValue['named'] as String),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfDateTimeNullableToJson(
        SimpleClassOfDateTimeNullable instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1?.toIso8601String(),
        'named': instance.value.named?.toIso8601String(),
      },
    };

SimpleClassNullableOfDateTimeNullable
    _$SimpleClassNullableOfDateTimeNullableFromJson(
            Map<String, dynamic> json) =>
        SimpleClassNullableOfDateTimeNullable(
          _$recordConvertNullable(
            json['value'],
            ($jsonValue) => (
              $jsonValue[r'$1'] == null
                  ? null
                  : DateTime.parse($jsonValue[r'$1'] as String),
              named: $jsonValue['named'] == null
                  ? null
                  : DateTime.parse($jsonValue['named'] as String),
            ),
          ),
        );

Map<String, dynamic> _$SimpleClassNullableOfDateTimeNullableToJson(
        SimpleClassNullableOfDateTimeNullable instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1?.toIso8601String(),
              'named': instance.value!.named?.toIso8601String(),
            },
    };

SimpleClassOfDouble _$SimpleClassOfDoubleFromJson(Map<String, dynamic> json) =>
    SimpleClassOfDouble(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          ($jsonValue[r'$1'] as num).toDouble(),
          named: ($jsonValue['named'] as num).toDouble(),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfDoubleToJson(
        SimpleClassOfDouble instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1,
        'named': instance.value.named,
      },
    };

SimpleClassNullableOfDouble _$SimpleClassNullableOfDoubleFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfDouble(
      _$recordConvertNullable(
        json['value'],
        ($jsonValue) => (
          ($jsonValue[r'$1'] as num).toDouble(),
          named: ($jsonValue['named'] as num).toDouble(),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassNullableOfDoubleToJson(
        SimpleClassNullableOfDouble instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1,
              'named': instance.value!.named,
            },
    };

SimpleClassOfDoubleNullable _$SimpleClassOfDoubleNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfDoubleNullable(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          ($jsonValue[r'$1'] as num?)?.toDouble(),
          named: ($jsonValue['named'] as num?)?.toDouble(),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfDoubleNullableToJson(
        SimpleClassOfDoubleNullable instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1,
        'named': instance.value.named,
      },
    };

SimpleClassNullableOfDoubleNullable
    _$SimpleClassNullableOfDoubleNullableFromJson(Map<String, dynamic> json) =>
        SimpleClassNullableOfDoubleNullable(
          _$recordConvertNullable(
            json['value'],
            ($jsonValue) => (
              ($jsonValue[r'$1'] as num?)?.toDouble(),
              named: ($jsonValue['named'] as num?)?.toDouble(),
            ),
          ),
        );

Map<String, dynamic> _$SimpleClassNullableOfDoubleNullableToJson(
        SimpleClassNullableOfDoubleNullable instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1,
              'named': instance.value!.named,
            },
    };

SimpleClassOfDuration _$SimpleClassOfDurationFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfDuration(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          Duration(microseconds: ($jsonValue[r'$1'] as num).toInt()),
          named: Duration(microseconds: ($jsonValue['named'] as num).toInt()),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfDurationToJson(
        SimpleClassOfDuration instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1.inMicroseconds,
        'named': instance.value.named.inMicroseconds,
      },
    };

SimpleClassNullableOfDuration _$SimpleClassNullableOfDurationFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfDuration(
      _$recordConvertNullable(
        json['value'],
        ($jsonValue) => (
          Duration(microseconds: ($jsonValue[r'$1'] as num).toInt()),
          named: Duration(microseconds: ($jsonValue['named'] as num).toInt()),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassNullableOfDurationToJson(
        SimpleClassNullableOfDuration instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1.inMicroseconds,
              'named': instance.value!.named.inMicroseconds,
            },
    };

SimpleClassOfDurationNullable _$SimpleClassOfDurationNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfDurationNullable(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          $jsonValue[r'$1'] == null
              ? null
              : Duration(microseconds: ($jsonValue[r'$1'] as num).toInt()),
          named: $jsonValue['named'] == null
              ? null
              : Duration(microseconds: ($jsonValue['named'] as num).toInt()),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfDurationNullableToJson(
        SimpleClassOfDurationNullable instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1?.inMicroseconds,
        'named': instance.value.named?.inMicroseconds,
      },
    };

SimpleClassNullableOfDurationNullable
    _$SimpleClassNullableOfDurationNullableFromJson(
            Map<String, dynamic> json) =>
        SimpleClassNullableOfDurationNullable(
          _$recordConvertNullable(
            json['value'],
            ($jsonValue) => (
              $jsonValue[r'$1'] == null
                  ? null
                  : Duration(microseconds: ($jsonValue[r'$1'] as num).toInt()),
              named: $jsonValue['named'] == null
                  ? null
                  : Duration(
                      microseconds: ($jsonValue['named'] as num).toInt()),
            ),
          ),
        );

Map<String, dynamic> _$SimpleClassNullableOfDurationNullableToJson(
        SimpleClassNullableOfDurationNullable instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1?.inMicroseconds,
              'named': instance.value!.named?.inMicroseconds,
            },
    };

SimpleClassOfDynamic _$SimpleClassOfDynamicFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfDynamic(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          $jsonValue[r'$1'],
          named: $jsonValue['named'],
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfDynamicToJson(
        SimpleClassOfDynamic instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1,
        'named': instance.value.named,
      },
    };

SimpleClassNullableOfDynamic _$SimpleClassNullableOfDynamicFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfDynamic(
      _$recordConvertNullable(
        json['value'],
        ($jsonValue) => (
          $jsonValue[r'$1'],
          named: $jsonValue['named'],
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassNullableOfDynamicToJson(
        SimpleClassNullableOfDynamic instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1,
              'named': instance.value!.named,
            },
    };

SimpleClassOfEnumType _$SimpleClassOfEnumTypeFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfEnumType(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          $enumDecode(_$EnumTypeEnumMap, $jsonValue[r'$1']),
          named: $enumDecode(_$EnumTypeEnumMap, $jsonValue['named']),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfEnumTypeToJson(
        SimpleClassOfEnumType instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': _$EnumTypeEnumMap[instance.value.$1]!,
        'named': _$EnumTypeEnumMap[instance.value.named]!,
      },
    };

const _$EnumTypeEnumMap = {
  EnumType.alpha: 'alpha',
  EnumType.beta: 'beta',
  EnumType.gamma: 'gamma',
  EnumType.delta: 'delta',
};

SimpleClassNullableOfEnumType _$SimpleClassNullableOfEnumTypeFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfEnumType(
      _$recordConvertNullable(
        json['value'],
        ($jsonValue) => (
          $enumDecode(_$EnumTypeEnumMap, $jsonValue[r'$1']),
          named: $enumDecode(_$EnumTypeEnumMap, $jsonValue['named']),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassNullableOfEnumTypeToJson(
        SimpleClassNullableOfEnumType instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': _$EnumTypeEnumMap[instance.value!.$1]!,
              'named': _$EnumTypeEnumMap[instance.value!.named]!,
            },
    };

SimpleClassOfEnumTypeNullable _$SimpleClassOfEnumTypeNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfEnumTypeNullable(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          $enumDecodeNullable(_$EnumTypeEnumMap, $jsonValue[r'$1']),
          named: $enumDecodeNullable(_$EnumTypeEnumMap, $jsonValue['named']),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfEnumTypeNullableToJson(
        SimpleClassOfEnumTypeNullable instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': _$EnumTypeEnumMap[instance.value.$1],
        'named': _$EnumTypeEnumMap[instance.value.named],
      },
    };

SimpleClassNullableOfEnumTypeNullable
    _$SimpleClassNullableOfEnumTypeNullableFromJson(
            Map<String, dynamic> json) =>
        SimpleClassNullableOfEnumTypeNullable(
          _$recordConvertNullable(
            json['value'],
            ($jsonValue) => (
              $enumDecodeNullable(_$EnumTypeEnumMap, $jsonValue[r'$1']),
              named:
                  $enumDecodeNullable(_$EnumTypeEnumMap, $jsonValue['named']),
            ),
          ),
        );

Map<String, dynamic> _$SimpleClassNullableOfEnumTypeNullableToJson(
        SimpleClassNullableOfEnumTypeNullable instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': _$EnumTypeEnumMap[instance.value!.$1],
              'named': _$EnumTypeEnumMap[instance.value!.named],
            },
    };

SimpleClassOfFromJsonDynamicParam _$SimpleClassOfFromJsonDynamicParamFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfFromJsonDynamicParam(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          FromJsonDynamicParam.fromJson($jsonValue[r'$1']),
          named: FromJsonDynamicParam.fromJson($jsonValue['named']),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfFromJsonDynamicParamToJson(
        SimpleClassOfFromJsonDynamicParam instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1,
        'named': instance.value.named,
      },
    };

SimpleClassNullableOfFromJsonDynamicParam
    _$SimpleClassNullableOfFromJsonDynamicParamFromJson(
            Map<String, dynamic> json) =>
        SimpleClassNullableOfFromJsonDynamicParam(
          _$recordConvertNullable(
            json['value'],
            ($jsonValue) => (
              FromJsonDynamicParam.fromJson($jsonValue[r'$1']),
              named: FromJsonDynamicParam.fromJson($jsonValue['named']),
            ),
          ),
        );

Map<String, dynamic> _$SimpleClassNullableOfFromJsonDynamicParamToJson(
        SimpleClassNullableOfFromJsonDynamicParam instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1,
              'named': instance.value!.named,
            },
    };

SimpleClassOfFromJsonNullableObjectParam
    _$SimpleClassOfFromJsonNullableObjectParamFromJson(
            Map<String, dynamic> json) =>
        SimpleClassOfFromJsonNullableObjectParam(
          _$recordConvert(
            json['value'],
            ($jsonValue) => (
              FromJsonNullableObjectParam.fromJson($jsonValue[r'$1']),
              named: FromJsonNullableObjectParam.fromJson($jsonValue['named']),
            ),
          ),
        );

Map<String, dynamic> _$SimpleClassOfFromJsonNullableObjectParamToJson(
        SimpleClassOfFromJsonNullableObjectParam instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1,
        'named': instance.value.named,
      },
    };

SimpleClassNullableOfFromJsonNullableObjectParam
    _$SimpleClassNullableOfFromJsonNullableObjectParamFromJson(
            Map<String, dynamic> json) =>
        SimpleClassNullableOfFromJsonNullableObjectParam(
          _$recordConvertNullable(
            json['value'],
            ($jsonValue) => (
              FromJsonNullableObjectParam.fromJson($jsonValue[r'$1']),
              named: FromJsonNullableObjectParam.fromJson($jsonValue['named']),
            ),
          ),
        );

Map<String, dynamic> _$SimpleClassNullableOfFromJsonNullableObjectParamToJson(
        SimpleClassNullableOfFromJsonNullableObjectParam instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1,
              'named': instance.value!.named,
            },
    };

SimpleClassOfFromJsonObjectParam _$SimpleClassOfFromJsonObjectParamFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfFromJsonObjectParam(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          FromJsonObjectParam.fromJson($jsonValue[r'$1'] as Object),
          named: FromJsonObjectParam.fromJson($jsonValue['named'] as Object),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfFromJsonObjectParamToJson(
        SimpleClassOfFromJsonObjectParam instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1,
        'named': instance.value.named,
      },
    };

SimpleClassNullableOfFromJsonObjectParam
    _$SimpleClassNullableOfFromJsonObjectParamFromJson(
            Map<String, dynamic> json) =>
        SimpleClassNullableOfFromJsonObjectParam(
          _$recordConvertNullable(
            json['value'],
            ($jsonValue) => (
              FromJsonObjectParam.fromJson($jsonValue[r'$1'] as Object),
              named:
                  FromJsonObjectParam.fromJson($jsonValue['named'] as Object),
            ),
          ),
        );

Map<String, dynamic> _$SimpleClassNullableOfFromJsonObjectParamToJson(
        SimpleClassNullableOfFromJsonObjectParam instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1,
              'named': instance.value!.named,
            },
    };

SimpleClassOfInt _$SimpleClassOfIntFromJson(Map<String, dynamic> json) =>
    SimpleClassOfInt(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          ($jsonValue[r'$1'] as num).toInt(),
          named: ($jsonValue['named'] as num).toInt(),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfIntToJson(SimpleClassOfInt instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1,
        'named': instance.value.named,
      },
    };

SimpleClassNullableOfInt _$SimpleClassNullableOfIntFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfInt(
      _$recordConvertNullable(
        json['value'],
        ($jsonValue) => (
          ($jsonValue[r'$1'] as num).toInt(),
          named: ($jsonValue['named'] as num).toInt(),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassNullableOfIntToJson(
        SimpleClassNullableOfInt instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1,
              'named': instance.value!.named,
            },
    };

SimpleClassOfIntNullable _$SimpleClassOfIntNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfIntNullable(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          ($jsonValue[r'$1'] as num?)?.toInt(),
          named: ($jsonValue['named'] as num?)?.toInt(),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfIntNullableToJson(
        SimpleClassOfIntNullable instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1,
        'named': instance.value.named,
      },
    };

SimpleClassNullableOfIntNullable _$SimpleClassNullableOfIntNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfIntNullable(
      _$recordConvertNullable(
        json['value'],
        ($jsonValue) => (
          ($jsonValue[r'$1'] as num?)?.toInt(),
          named: ($jsonValue['named'] as num?)?.toInt(),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassNullableOfIntNullableToJson(
        SimpleClassNullableOfIntNullable instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1,
              'named': instance.value!.named,
            },
    };

SimpleClassOfNum _$SimpleClassOfNumFromJson(Map<String, dynamic> json) =>
    SimpleClassOfNum(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          $jsonValue[r'$1'] as num,
          named: $jsonValue['named'] as num,
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfNumToJson(SimpleClassOfNum instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1,
        'named': instance.value.named,
      },
    };

SimpleClassNullableOfNum _$SimpleClassNullableOfNumFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfNum(
      _$recordConvertNullable(
        json['value'],
        ($jsonValue) => (
          $jsonValue[r'$1'] as num,
          named: $jsonValue['named'] as num,
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassNullableOfNumToJson(
        SimpleClassNullableOfNum instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1,
              'named': instance.value!.named,
            },
    };

SimpleClassOfNumNullable _$SimpleClassOfNumNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfNumNullable(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          $jsonValue[r'$1'] as num?,
          named: $jsonValue['named'] as num?,
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfNumNullableToJson(
        SimpleClassOfNumNullable instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1,
        'named': instance.value.named,
      },
    };

SimpleClassNullableOfNumNullable _$SimpleClassNullableOfNumNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfNumNullable(
      _$recordConvertNullable(
        json['value'],
        ($jsonValue) => (
          $jsonValue[r'$1'] as num?,
          named: $jsonValue['named'] as num?,
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassNullableOfNumNullableToJson(
        SimpleClassNullableOfNumNullable instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1,
              'named': instance.value!.named,
            },
    };

SimpleClassOfObject _$SimpleClassOfObjectFromJson(Map<String, dynamic> json) =>
    SimpleClassOfObject(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          $jsonValue[r'$1'] as Object,
          named: $jsonValue['named'] as Object,
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfObjectToJson(
        SimpleClassOfObject instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1,
        'named': instance.value.named,
      },
    };

SimpleClassNullableOfObject _$SimpleClassNullableOfObjectFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfObject(
      _$recordConvertNullable(
        json['value'],
        ($jsonValue) => (
          $jsonValue[r'$1'] as Object,
          named: $jsonValue['named'] as Object,
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassNullableOfObjectToJson(
        SimpleClassNullableOfObject instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1,
              'named': instance.value!.named,
            },
    };

SimpleClassOfObjectNullable _$SimpleClassOfObjectNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfObjectNullable(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          $jsonValue[r'$1'],
          named: $jsonValue['named'],
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfObjectNullableToJson(
        SimpleClassOfObjectNullable instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1,
        'named': instance.value.named,
      },
    };

SimpleClassNullableOfObjectNullable
    _$SimpleClassNullableOfObjectNullableFromJson(Map<String, dynamic> json) =>
        SimpleClassNullableOfObjectNullable(
          _$recordConvertNullable(
            json['value'],
            ($jsonValue) => (
              $jsonValue[r'$1'],
              named: $jsonValue['named'],
            ),
          ),
        );

Map<String, dynamic> _$SimpleClassNullableOfObjectNullableToJson(
        SimpleClassNullableOfObjectNullable instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1,
              'named': instance.value!.named,
            },
    };

SimpleClassOfRecord _$SimpleClassOfRecordFromJson(Map<String, dynamic> json) =>
    SimpleClassOfRecord(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          _$recordConvert(
            $jsonValue[r'$1'],
            ($jsonValue) => (
              ($jsonValue[r'$1'] as num).toInt(),
              $jsonValue[r'$2'] as String,
              truth: $jsonValue['truth'] as bool,
            ),
          ),
          named: _$recordConvert(
            $jsonValue['named'],
            ($jsonValue) => (
              ($jsonValue[r'$1'] as num).toInt(),
              $jsonValue[r'$2'] as String,
              truth: $jsonValue['truth'] as bool,
            ),
          ),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfRecordToJson(
        SimpleClassOfRecord instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': <String, dynamic>{
          r'$1': instance.value.$1.$1,
          r'$2': instance.value.$1.$2,
          'truth': instance.value.$1.truth,
        },
        'named': <String, dynamic>{
          r'$1': instance.value.named.$1,
          r'$2': instance.value.named.$2,
          'truth': instance.value.named.truth,
        },
      },
    };

SimpleClassNullableOfRecord _$SimpleClassNullableOfRecordFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfRecord(
      _$recordConvertNullable(
        json['value'],
        ($jsonValue) => (
          _$recordConvert(
            $jsonValue[r'$1'],
            ($jsonValue) => (
              ($jsonValue[r'$1'] as num).toInt(),
              $jsonValue[r'$2'] as String,
              truth: $jsonValue['truth'] as bool,
            ),
          ),
          named: _$recordConvert(
            $jsonValue['named'],
            ($jsonValue) => (
              ($jsonValue[r'$1'] as num).toInt(),
              $jsonValue[r'$2'] as String,
              truth: $jsonValue['truth'] as bool,
            ),
          ),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassNullableOfRecordToJson(
        SimpleClassNullableOfRecord instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': <String, dynamic>{
                r'$1': instance.value!.$1.$1,
                r'$2': instance.value!.$1.$2,
                'truth': instance.value!.$1.truth,
              },
              'named': <String, dynamic>{
                r'$1': instance.value!.named.$1,
                r'$2': instance.value!.named.$2,
                'truth': instance.value!.named.truth,
              },
            },
    };

SimpleClassOfString _$SimpleClassOfStringFromJson(Map<String, dynamic> json) =>
    SimpleClassOfString(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          $jsonValue[r'$1'] as String,
          named: $jsonValue['named'] as String,
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfStringToJson(
        SimpleClassOfString instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1,
        'named': instance.value.named,
      },
    };

SimpleClassNullableOfString _$SimpleClassNullableOfStringFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfString(
      _$recordConvertNullable(
        json['value'],
        ($jsonValue) => (
          $jsonValue[r'$1'] as String,
          named: $jsonValue['named'] as String,
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassNullableOfStringToJson(
        SimpleClassNullableOfString instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1,
              'named': instance.value!.named,
            },
    };

SimpleClassOfStringNullable _$SimpleClassOfStringNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfStringNullable(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          $jsonValue[r'$1'] as String?,
          named: $jsonValue['named'] as String?,
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfStringNullableToJson(
        SimpleClassOfStringNullable instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1,
        'named': instance.value.named,
      },
    };

SimpleClassNullableOfStringNullable
    _$SimpleClassNullableOfStringNullableFromJson(Map<String, dynamic> json) =>
        SimpleClassNullableOfStringNullable(
          _$recordConvertNullable(
            json['value'],
            ($jsonValue) => (
              $jsonValue[r'$1'] as String?,
              named: $jsonValue['named'] as String?,
            ),
          ),
        );

Map<String, dynamic> _$SimpleClassNullableOfStringNullableToJson(
        SimpleClassNullableOfStringNullable instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1,
              'named': instance.value!.named,
            },
    };

SimpleClassOfUri _$SimpleClassOfUriFromJson(Map<String, dynamic> json) =>
    SimpleClassOfUri(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          Uri.parse($jsonValue[r'$1'] as String),
          named: Uri.parse($jsonValue['named'] as String),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfUriToJson(SimpleClassOfUri instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1.toString(),
        'named': instance.value.named.toString(),
      },
    };

SimpleClassNullableOfUri _$SimpleClassNullableOfUriFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfUri(
      _$recordConvertNullable(
        json['value'],
        ($jsonValue) => (
          Uri.parse($jsonValue[r'$1'] as String),
          named: Uri.parse($jsonValue['named'] as String),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassNullableOfUriToJson(
        SimpleClassNullableOfUri instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1.toString(),
              'named': instance.value!.named.toString(),
            },
    };

SimpleClassOfUriNullable _$SimpleClassOfUriNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassOfUriNullable(
      _$recordConvert(
        json['value'],
        ($jsonValue) => (
          $jsonValue[r'$1'] == null
              ? null
              : Uri.parse($jsonValue[r'$1'] as String),
          named: $jsonValue['named'] == null
              ? null
              : Uri.parse($jsonValue['named'] as String),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassOfUriNullableToJson(
        SimpleClassOfUriNullable instance) =>
    <String, dynamic>{
      'value': <String, dynamic>{
        r'$1': instance.value.$1?.toString(),
        'named': instance.value.named?.toString(),
      },
    };

SimpleClassNullableOfUriNullable _$SimpleClassNullableOfUriNullableFromJson(
        Map<String, dynamic> json) =>
    SimpleClassNullableOfUriNullable(
      _$recordConvertNullable(
        json['value'],
        ($jsonValue) => (
          $jsonValue[r'$1'] == null
              ? null
              : Uri.parse($jsonValue[r'$1'] as String),
          named: $jsonValue['named'] == null
              ? null
              : Uri.parse($jsonValue['named'] as String),
        ),
      ),
    );

Map<String, dynamic> _$SimpleClassNullableOfUriNullableToJson(
        SimpleClassNullableOfUriNullable instance) =>
    <String, dynamic>{
      'value': instance.value == null
          ? null
          : <String, dynamic>{
              r'$1': instance.value!.$1?.toString(),
              'named': instance.value!.named?.toString(),
            },
    };
