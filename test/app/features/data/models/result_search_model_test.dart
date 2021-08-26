import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/features/data/models/result_search_model.dart';
import 'package:mobile_challenge/app/features/domain/entities/result_search.dart';

import '../../../../fixtures/json_reader.dart';

main() {
  final resultSearchModel = ResultSearchModel(
    username: 'any_username',
    imageUrl: 'any_image',
  );

  test('Should be a ResultSearch entity', () {
    expect(resultSearchModel, isA<ResultSearch>());
  });

  test('Should return a list after from json factory called', () {
    final decodedJson = json.decode(jsonReader('result_search.json'));
    final resultSearchList = (decodedJson['items'] as List)
        .map((item) => ResultSearchModel.fromJson(item))
        .toList();
    expect(resultSearchList[0], isA<ResultSearch>());
  });

  test('Should return a mapped json from ResultSearchModel', () {
    final result = resultSearchModel.toJson();
    final map = <String, dynamic>{
      'login': resultSearchModel.username,
      'avatar_url': resultSearchModel.imageUrl,
    };
    expect(result, map);
  });
}
