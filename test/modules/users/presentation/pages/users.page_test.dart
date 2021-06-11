import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/core/utils/constants.dart';
import 'package:mobile_challenge/app/core/utils/keys.dart';
import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';
import 'package:mobile_challenge/app/modules/users/domain/usecases/get_search_users.usecase.dart';
import 'package:mobile_challenge/app/modules/users/domain/usecases/get_users.usecase.dart';
import 'package:mobile_challenge/app/modules/users/presentation/controllers/users_controller.dart';
import 'package:mobile_challenge/app/modules/users/presentation/pages/users.page.dart';
import 'package:mobile_challenge/app/modules/users/users_module.dart';
import 'package:dartz/dartz.dart' as Dartz;
import 'package:mockito/mockito.dart';
import '../controllers/users.controller_test.dart';

main() {
  final _usecaseGeneral = GetUsersUsecaseMock();
  final _searchUsecaseGeneral = GetSearchUsersUsecaseMock();
  final controllerUser =
      UsersController(_usecaseGeneral, _searchUsecaseGeneral);
  UsersController _controller;
  GetUsersUsecase _usecase;
  GetSearchUsersUsecase _searchUsecase;
  List<UserEntity> listEntity = [
    UserEntity(id: 1, avatarUrl: "http://www.dsdds.com/jwijd", login: "b")
  ];
  var resultSuccess = Dartz.Right<Exception, List<UserEntity>>(listEntity);

  setUp(() {
    var offerModule = UsersModule()
      ..cleanInjects()
      ..changeBinds([
        Bind((i) => controllerUser),
        Bind((i) => _usecaseGeneral),
        Bind((i) => _searchUsecaseGeneral),
      ]);
    initModule(offerModule);
    HttpOverrides.global = null;
    WidgetsFlutterBinding.ensureInitialized();
    _controller = Modular.get();
    _usecase = Modular.get();
    _searchUsecase = Modular.get();
  });

  initWidget() {
    int input = 0;
    _controller.page = 1;
    when(_usecase(input)).thenAnswer((_) async => resultSuccess);
  }

  testWidgets('Should change loading', (WidgetTester tester) async {
    initWidget();
    await tester.runAsync(() async {
      var page = UsersPage();
      await tester.pumpWidget(MaterialApp(home: Material(child: page)));
      _controller.changeLoading(true);
      await tester.pump();
      final progress = find.byKey(Key(Keys.LOADING));
      expect(progress, findsOneWidget);
      _controller.changeLoading(false);
      await tester.pump();
      expect(progress, findsNothing);
    });
  });

  testWidgets('Should change loadingBottom', (WidgetTester tester) async {
    initWidget();
    await tester.runAsync(() async {
      var page = UsersPage();
      await tester.pumpWidget(MaterialApp(home: Material(child: page)));
      _controller.changeLoadingBottom(true);
      await tester.pump();
      final progress = find.byKey(Key(Keys.LOADING_BUTTON));
      expect(progress, findsOneWidget);
      _controller.changeLoadingBottom(false);
      await tester.pump();
      expect(progress, findsNothing);
    });
  });

  testWidgets('Should change error', (WidgetTester tester) async {
    initWidget();
    await tester.runAsync(() async {
      var page = UsersPage();
      await tester.pumpWidget(MaterialApp(home: Material(child: page)));
      _controller.changeError(true);
      await tester.pump();
      final button = find.text(Constants.TRY_AGAIN_BUTTON);
      expect(button, findsOneWidget);
      _controller.changeError(false);
      await tester.pump();
      expect(button, findsNothing);
    });
  });

  testWidgets('Should number of list user equal a number of UserItem widget',
      (WidgetTester tester) async {
    initWidget();
    await tester.runAsync(() async {
      var page = UsersPage();
      await tester.pumpWidget(MaterialApp(home: Material(child: page)));
      _controller.changeUsers(
          [UserEntity(avatarUrl: "http://sss.com/sjj", login: "as", id: 1)]);
      await tester.pump();
      final text = find.text('as');
      expect(text, findsOneWidget);
      _controller.changeUsers([]);
      await tester.pump();
      expect(text, findsNothing);
    });
  });

  testWidgets('Should have a title', (WidgetTester tester) async {
    initWidget();
    await tester.runAsync(() async {
      var page = UsersPage();
      await tester.pumpWidget(MaterialApp(home: Material(child: page)));
      final text = find.text(Constants.USERS_TITLE);
      await tester.pump();
      expect(text, findsOneWidget);
    });
  });

  testWidgets('Should search when button is pressed',
      (WidgetTester tester) async {
    initWidget();
    _controller.page = 1;
    _controller.searchValue = "a";
    var input = 1;
    when(_searchUsecase("a", input)).thenAnswer((_) async => resultSuccess);
    await tester.runAsync(() async {
      var page = UsersPage();
      await tester.pumpWidget(MaterialApp(home: Material(child: page)));
      final button = find.byKey(Key(Keys.SEARCH_BUTTON));
      OutlinedButton send = button.evaluate().first.widget;
      send.onPressed();
      await tester.pump(const Duration(milliseconds: 900));
      final text = find.text("b");
      await tester.pump();
      expect(text, findsOneWidget);
      _controller.changeUsers([]);
      await tester.pump();
      expect(text, findsNothing);
    });
  });
  testWidgets('Should onTap try again button reload page',
      (WidgetTester tester) async {
    initWidget();
    var page = UsersPage();
    await tester.pumpWidget(MaterialApp(home: Material(child: page)));
    _controller.changeError(true);
    await tester.pump();
    final button = find.byKey(Key(Keys.TRY_AGAIN));
    await tester.pump();
    InkWell send = button.evaluate().first.widget;
    _controller.page = 1;
    send.onTap();
    await tester.pump(const Duration(milliseconds: 900));
    final text = find.text("b");
    await tester.pump();
    expect(text, findsOneWidget);
    _controller.changeUsers([]);
    await tester.pump();
    expect(text, findsNothing);
  });
}
