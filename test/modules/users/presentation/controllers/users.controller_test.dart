import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';
import 'package:mobile_challenge/app/modules/users/domain/usecases/get_search_users.usecase.dart';
import 'package:mobile_challenge/app/modules/users/domain/usecases/get_users.usecase.dart';
import 'package:mobile_challenge/app/modules/users/presentation/controllers/users_controller.dart';
import 'package:mockito/mockito.dart';

class GetUsersUsecaseMock extends Mock implements GetUsersUsecase {}

class GetSearchUsersUsecaseMock extends Mock implements GetSearchUsersUsecase {}

main() {
  final GetUsersUsecase _usecase = GetUsersUsecaseMock();
  final GetSearchUsersUsecase _searchUsecase = GetSearchUsersUsecaseMock();
  UsersController _controller;
  List<UserEntity> listEntity = [UserEntity(id: 1, avatarUrl: "", login: "")];
  var resultSuccess = Right<Exception, List<UserEntity>>(listEntity);
  var resultError = Left<Exception, List<UserEntity>>(Exception(null));

  setUp(() {
    _controller = UsersController(_usecase, _searchUsecase);
  });

  test('Should controller call usecase', () async {
    int input = 0;
    _controller.page = 1;
    when(_usecase(input)).thenAnswer((_) async => resultSuccess);
    await _controller.getUsers();
    verify(_usecase(input)).called(1);
  });

  test('Should controller call searchUsecase', () async {
    int input = 1;
    _controller.searchValue = "a";
    _controller.page = 1;
    when(_searchUsecase(_controller.searchValue, input))
        .thenAnswer((_) async => resultSuccess);
    await _controller.getSearchUsers();
    verify(_searchUsecase(_controller.searchValue, input)).called(1);
  });

  test('Should isSearch equal false when searchValue empty', () async {
    int input = 0;
    when(_usecase(input)).thenAnswer((_) async => resultSuccess);
    _controller.searchValue = "";
    await _controller.getUserListForSearch();
    expect(_controller.isSearching, false);
  });

  test('Should isSearch equal true when searchValue empty', () async {
    int input = 1;
    _controller.searchValue = "a";
    when(_searchUsecase(_controller.searchValue, input))
        .thenAnswer((_) async => resultSuccess);
    await _controller.getUserListForSearch();
    expect(_controller.isSearching, true);
  });

  test('Should call getUsers when isSearching equal false', () async {
    _controller.isSearching = false;
    int input = 0;
    when(_usecase(input)).thenAnswer((_) async => resultSuccess);
    await _controller.getUserList();
    expect(_controller.users, listEntity);
  });

  test('Should call getSearchUsers when isSearching equal true', () async {
    _controller.isSearching = true;
    int input = 1;
    when(_searchUsecase(_controller.searchValue, input))
        .thenAnswer((_) async => resultSuccess);
    await _controller.getSearchUsers();
    expect(_controller.users, listEntity);
  });

  group('loading - ', () {
    test('Should loading false when finish call usecase', () async {
      int input = 0;
      when(_usecase(input)).thenAnswer((_) async => resultSuccess);
      await _controller.getUsers();
      expect(_controller.isLoading, false);
    });
    test('Should loadingBottom false when finish call usecase', () async {
      int input = 0;
      _controller.page = 2;
      when(_usecase(input)).thenAnswer((_) async => resultSuccess);
      await _controller.getUsers();
      expect(_controller.isLoadingBottom, false);
    });

    test('Should loading false when finish call searchUsecase', () async {
      int input = 1;
      _controller.searchValue = "a";
      when(_searchUsecase(_controller.searchValue, input))
          .thenAnswer((_) async => resultSuccess);
      await _controller.getSearchUsers();
      expect(_controller.isLoading, false);
    });

    test('Should loadingBottom false when finish call searchUsecase', () async {
      int input = 2;
      _controller.searchValue = "a";
      _controller.page = 2;
      when(_searchUsecase(_controller.searchValue, input))
          .thenAnswer((_) async => resultSuccess);
      await _controller.getSearchUsers();
      expect(_controller.isLoadingBottom, false);
    });
  });

  group('error - ', () {
    test('Should isError true when finish call usecase', () async {
      int input = 0;
      when(_usecase(input)).thenAnswer((_) async => resultError);
      await _controller.getUsers();
      expect(_controller.isError, true);
    });
    test('Should isError false when finish call usecase', () async {
      int input = 0;
      _controller.page = 2;
      when(_usecase(input)).thenAnswer((_) async => resultError);
      await _controller.getUsers();
      expect(_controller.isError, false);
    });

    test('Should isError true when finish call searchUsecase', () async {
      int input = 1;
      _controller.searchValue = "a";
      when(_searchUsecase(_controller.searchValue, input))
          .thenAnswer((_) async => resultError);
      await _controller.getSearchUsers();
      expect(_controller.isError, true);
    });

    test('Should isError false when finish call searchUsecase', () async {
      int input = 2;
      _controller.searchValue = "a";
      _controller.page = 2;
      when(_searchUsecase(_controller.searchValue, input))
          .thenAnswer((_) async => resultError);
      await _controller.getSearchUsers();
      expect(_controller.isError, false);
    });
  });
}
