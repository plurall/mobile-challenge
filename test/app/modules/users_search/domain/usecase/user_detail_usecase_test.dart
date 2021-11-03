import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/core/erros/failures.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/entity/user_entity.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/repository/user_detail_repository.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/usecase/user_detail_usecase.dart';
import 'package:mocktail/mocktail.dart';

class UserDetailRepositoryMock extends Mock implements IUserDetailRepository {}

void main() {
  late UserDetailUsecase _usecase;
  late UserDetailRepositoryMock _repository;
  final detailUrl = '';
  final UserEntity userEntity = UserEntity(
    login: 'login',
    id: 0,
    nodeId: 'nodeId',
    avatarUrl: 'avatarUrl',
    gravatarId: 'gravatarId',
    url: 'url',
    htmlUrl: 'htmlUrl',
    followersUrl: 'followersUrl',
    followingUrl: 'followingUrl',
    gistsUrl: 'gistsUrl',
    starredUrl: 'starredUrl',
    subscriptionsUrl: 'subscriptionsUrl',
    organizationsUrl: 'organizationsUrl',
    reposUrl: 'reposUrl',
    eventsUrl: 'eventsUrl',
    receivedEventsUrl: 'receivedEventsUrl',
    type: 'type',
    siteAdmin: true,
  );

  setUp(() {
    _repository = UserDetailRepositoryMock();
    _usecase = UserDetailUsecase(_repository);
  });

  group('Users search', () {
    test('Should return user list - UserEntity', () async {
      // Arrange
      when(() => _repository.userDetail(detailUrl)).thenAnswer(
        (_) async => Right<Failure, UserEntity>(userEntity),
      );
      // Actual
      final result = await _usecase.userDetail(detailUrl);
      // Assert
      expect(result, Right(userEntity));
      verify(() => _repository.userDetail(detailUrl)).called(1);
    });
    test('Should return a Failure', () async {
      // Arrange
      when(() => _repository.userDetail(detailUrl)).thenAnswer(
        (_) async => Left<Failure, UserEntity>(
          ServerFailure(message: 'ServerFaiure'),
        ),
      );
      // Actual
      final result = await _usecase.userDetail(detailUrl);
      // Assert
      expect(result, Left(ServerFailure(message: 'ServerFaiure')));
      verify(() => _repository.userDetail(detailUrl)).called(1);
    });
  });
}
