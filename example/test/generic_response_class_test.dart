// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:example/generic_response_class_example.dart';
import 'package:test/test.dart';

const _jsonUser = {
  'status': 200,
  'msg': 'success',
  'data': {'id': 1, 'email': 'test@test.com'}
};

final _jsonArticle = {
  'status': 200,
  'msg': 'success',
  'data': {
    'id': 2,
    'title': 'title1',
    'author': _jsonUser['data'],
    'comments': [
      {'content': 'comment context', 'id': 1},
      {'content': 'comment context', 'id': 2},
    ]
  }
};

final _jsonArticleList = {
  'status': 200,
  'msg': 'success',
  'data': [
    {'id': 1, 'title': 'title1'},
    _jsonArticle['data'],
  ]
};

void _testResponse<T>(BaseResponse response, void Function(T) testFunction) {
  expect(response.status, 200);
  expect(response.msg, 'success');
  testFunction(response.data as T);
}

void _testUser(User user) {
  expect(user.email, 'test@test.com');
  expect(user.id, 1);
}

void _testArticle(Article article) {
  expect(article.id, 2);
  expect(article.title, 'title1');
  _testUser(article.author!);
  expect(article.comments, hasLength(2));
}

void _testArticleList(List<Article> articles) {
  expect(articles, hasLength(2));
  _testArticle(articles[1]);
}

void main() {
  test('user', () {
    _testResponse(BaseResponse<User>.fromJson(_jsonUser), _testUser);
    // without generic
    _testResponse(BaseResponse.fromJson(_jsonUser), _testUser);
  });

  test('article', () {
    _testResponse(BaseResponse<Article>.fromJson(_jsonArticle), _testArticle);
    // without generic
    _testResponse(BaseResponse.fromJson(_jsonArticle), _testArticle);
  });

  test('article list', () {
    _testResponse(
      BaseResponse<List<Article>>.fromJson(_jsonArticleList),
      _testArticleList,
    );

    // without generic
    _testResponse(BaseResponse.fromJson(_jsonArticleList), _testArticleList);
  });
}
