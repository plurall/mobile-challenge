import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/app.module.dart';
import 'package:mobile_challenge/app/app_bloc.dart';
import 'package:mobile_challenge/app/pages/search/search_module.dart';
import 'package:mobile_challenge/app/pages/search/search_page.dart';
import 'package:mobile_challenge/app/pages/search/search_page_bloc.dart';

import 'package:mobile_challenge/app/pages/search/search_repository.dart';
import 'package:mobile_challenge/app/shared/custom_dio/custom_dio.dart';

void main() {
  final respoitory = SearchRepository(CustomDio());

  test('Test fetch user', () async {
    final listItems = await respoitory.searchText('Withi');
    expect(listItems[0].login, 'Withi');
  });
}
