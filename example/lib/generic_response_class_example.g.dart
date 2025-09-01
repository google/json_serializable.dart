// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_response_class_example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse<T> _$BaseResponseFromJson<T>(Map<String, dynamic> json) =>
    BaseResponse<T>(
      status: double.tryParse(json['status'].toString())?.toInt(),
      msg: json['msg']?.toString(),
      data: BaseResponse._dataFromJson(json['data'] as Object),
    );

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
  id: json['id'] as int,
  title: json['title'] as String,
  author: json['author'] == null || json['author'] is! Map
      ? null
      : User.fromJson(json['author'] as Map<String, dynamic>),
  comments: (json['comments'] is List)
      ? (json['comments'] as List<dynamic>?)
            ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
            .toList()
      : [],
);

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: double.tryParse(json['id'].toString())?.toInt(),
  email: json['email']?.toString(),
);

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
  id: double.tryParse(json['id'].toString())?.toInt(),
  content: json['content']?.toString(),
);
