import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/core/erros/failures.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/entity/user_entity.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/entity/user_list_entity.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/usecase/user_search_usecase.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/repository/user_search_respository.dart';

class UserSearchRepositoryMock extends Mock implements IUserSearchRepository {}

void main() {
  late UserSearchUsecase _usecase;
  late UserSearchRepositoryMock _repository;
  final searchTerm = '';
  final listUser = UserListEntity(userListEntity: <UserEntity>[]);

  setUp(() {
    _repository = UserSearchRepositoryMock();
    _usecase = UserSearchUsecase(_repository);
  });

  group('Users search', () {
    test('Should return user list - UserEntity', () async {
      // Arrange
      when(() => _repository.userSearch(searchTerm)).thenAnswer(
        (_) async => Right<Failure, UserListEntity>(listUser),
      );
      // Actual
      final result = await _usecase.userSearch(searchTerm);
      // Assert
      expect(result, Right(listUser));
      verify(() => _repository.userSearch(searchTerm)).called(1);
    });
    test('Should return a Failure', () async {
      // Arrange
      when(() => _repository.userSearch(searchTerm)).thenAnswer(
        (_) async => Left<Failure, UserListEntity>(
          ServerFailure(message: 'ServerFaiure'),
        ),
      );
      // Actual
      final result = await _usecase.userSearch(searchTerm);
      // Assert
      expect(result, Left(ServerFailure(message: 'ServerFaiure')));
      verify(() => _repository.userSearch(searchTerm)).called(1);
    });
  });
}
