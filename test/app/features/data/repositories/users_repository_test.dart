import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/core/errors/errors.dart';
import 'package:mobile_challenge/app/features/data/datasources/users_datasource.dart';
import 'package:mobile_challenge/app/features/data/repositories/users_repository.dart';
import 'package:mobile_challenge/app/features/domain/entities/user.dart';
import 'package:mobile_challenge/app/features/infra/drivers/users_driver.dart';
import 'package:mocktail/mocktail.dart';

class UsersDataSourceMock extends Mock implements UsersDatasource {}

class UsersDriverMock extends Mock implements UsersDriver {}

void main() {
  final datasource = UsersDataSourceMock();
  final driver = UsersDriverMock();
  final repository = UsersRepositoryImpl(datasource, driver);
  final user = User(username: 'any_user');
  final userList = [user];

  test('Should return a User data', () async {
    when(() => datasource.getUser(any())).thenAnswer((_) async => user);
    final result = await repository.getUser('any_user');
    expect(result.fold(id, id), isA<User>());
  });

  test('Should throws DatasourceError if datasource fails', () async {
    when(() => datasource.getUser(any())).thenThrow(DatasourceError());
    final result = await repository.getUser('any_user');
    expect(result.fold(id, id), isA<DatasourceError>());
  });

  test('Should return a user favorites list', () async {
    when(() => driver.getFavoritesUsers()).thenAnswer((_) async => userList);
    final result = await repository.getFavoritesUsers();
    expect(result.fold(id, id), isA<List<User>>());
  });

  test('Should throws an CacheError if driver fails on getFavoritesUsers',
      () async {
    when(() => driver.getFavoritesUsers()).thenThrow(CacheError());
    final result = await repository.getFavoritesUsers();
    expect(result.fold(id, id), isA<CacheError>());
  });

  test('Should save the user favorite with success', () async {
    when(() => driver.saveFavoritesUser(user)).thenAnswer((_) async => true);
    final result = await repository.saveFavoriteUser(user);
    expect(result.fold(id, id), isA<bool>());
  });

  test('Should throws an CacheError if driver fails on saveFavorite', () async {
    when(() => driver.saveFavoritesUser(user)).thenThrow(CacheError());
    final result = await repository.saveFavoriteUser(user);
    expect(result.fold(id, id), isA<CacheError>());
  });
}
