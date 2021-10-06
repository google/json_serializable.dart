// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_response_class_example.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse<T> _$BaseResponseFromJson<T>(Map<String, dynamic> json) =>
    BaseResponse<T>(
      status: json['status'] as int?,
      msg: json['msg'] as String?,
      data: BaseResponse._dataFromJson(json['data'] as Object),
    );

class _$BaseResponseFields {
  const _$BaseResponseFields();
  final String status = 'status';
  final String msg = 'msg';
  final String data = 'data';
}

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] == null
          ? null
          : User.fromJson(json['author'] as Map<String, dynamic>),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

class _$ArticleFields {
  const _$ArticleFields();
  final String id = 'id';
  final String title = 'title';
  final String author = 'author';
  final String comments = 'comments';
}

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      email: json['email'] as String?,
    );

class _$UserFields {
  const _$UserFields();
  final String id = 'id';
  final String email = 'email';
}

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as int?,
      content: json['content'] as String?,
    );

class _$CommentFields {
  const _$CommentFields();
  final String content = 'content';
  final String id = 'id';
}
