// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/modules/user_list/data/datasources/user_list_remote_data_source.dart';
import 'package:mobile_challenge/modules/user_list/data/models/user_search_model.dart';

import 'package:mobile_challenge/modules/user_list/presentation/user_list_page.dart';
import 'package:mobile_challenge/modules/user_list/user_list.dart';

class MochSource implements UserListRemoteDataSourceProtocol {
  @override
  Future<UserSearchApiModel> getSearch(String query, {int page = 1}) {
    print("mochSearch Called");
    UserSearchApiModel.fromJson({
      'total_count': 0,
      'incomplete_results': false,
      'items': [{}]
    });
  }
}

void main() {
  testWidgets('Should load inital screen with default list',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(UserList(remoteDataSource: MochSource()).routeToPage());
    await tester.pump(Duration(seconds: 100));
    // var resp = tester.firstState(find.ancestor(UserListPage()));
    // print(resp);
    var base = find.byElementType(Scaffold);
    expect(base, findsOneWidget);
    // var list = find.byKey(Key('UserListPageListView'));
    // expect(list, findsOneWidget);
  });
}
