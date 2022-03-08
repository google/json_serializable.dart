// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_response_class_example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse<T> _$BaseResponseFromJson<T>(Map<String, dynamic> json) =>
    $checkedCreate(
      'BaseResponse',
      json,
      ($checkedConvert) {
        final val = BaseResponse<T>(
          status: json['status'] is int?
              ? $checkedConvert('status', (v) => v as int?)
              : null,
          msg: json['msg'] is String?
              ? $checkedConvert('msg', (v) => v as String?)
              : null,
          data: json['data'] is T?
              ? $checkedConvert(
                  'data', (v) => BaseResponse._dataFromJson(v as Object))
              : null,
        );
        return val;
      },
    );

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] is User?
          ? json['author'] == null
              ? null
              : User.fromJson(json['author'] as Map<String, dynamic>)
          : null,
      comments: json['comments'] is List<Comment>?
          ? (json['comments'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] is int? ? json['id'] as int? : null,
      email: json['email'] is String? ? json['email'] as String? : null,
    );

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] is int? ? json['id'] as int? : null,
      content: json['content'] is String? ? json['content'] as String? : null,
    );
