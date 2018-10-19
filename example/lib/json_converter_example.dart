// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:json_annotation/json_annotation.dart';

part 'json_converter_example.g.dart';

@JsonSerializable()
class GenericCollection<T> {
  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'total_results')
  final int totalResults;

  @JsonKey(name: 'total_pages')
  final int totalPages;

  @JsonKey(name: 'results')
  @_Converter()
  final List<T> results;

  GenericCollection(
      {this.page, this.totalResults, this.totalPages, this.results});

  factory GenericCollection.fromJson(Map<String, dynamic> json) =>
      _$GenericCollectionFromJson<T>(json);

  Map<String, dynamic> toJson() => _$GenericCollectionToJson(this);
}

class _Converter<T> implements JsonConverter<T, Object> {
  const _Converter();

  @override
  T fromJson(Object json) {
    if (json is Map<String, dynamic> &&
        json.containsKey('name') &&
        json.containsKey('size')) {
      return CustomResult.fromJson(json) as T;
    }
    // This will only work if `json` is a native JSON type:
    //   num, String, bool, null, etc
    // *and* is assignable to `T`.
    return json as T;
  }

  @override
  Object toJson(T object) {
    // This will only work if `object` is a native JSON type:
    //   num, String, bool, null, etc
    // Or if it has a `toJson()` function`.
    return object;
  }
}

@JsonSerializable()
class CustomResult {
  final String name;
  final int size;

  CustomResult(this.name, this.size);

  factory CustomResult.fromJson(Map<String, dynamic> json) =>
      _$CustomResultFromJson(json);

  Map<String, dynamic> toJson() => _$CustomResultToJson(this);

  @override
  bool operator ==(Object other) =>
      other is CustomResult && other.name == name && other.size == size;

  @override
  int get hashCode => name.hashCode * 31 ^ size.hashCode;
}
