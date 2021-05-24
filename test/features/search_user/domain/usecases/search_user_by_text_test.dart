import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/core/error/failures.dart';
import 'package:mobile_challenge/features/search_user/domain/entities/user_entity.dart';
import 'package:mobile_challenge/features/search_user/domain/repositories/search_user_repository.dart';
import 'package:mobile_challenge/features/search_user/domain/usecases/search_user_by_text.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_user_by_text_test.mocks.dart';

@GenerateMocks([ISearchUserRepository])
void main() {
  late SearchUserByTextDatasource usecase;
  late ISearchUserRepository repository;

  setUp(() {
    repository = MockISearchUserRepository();
    usecase = SearchUserByTextDatasource(repository);
  });
  test('should get user by text from repository', () async {
    List<UserEntity> resultUsers = [
      UserEntity(image: 'image', nickname: 'nickname')
    ];

    when(repository.getUsers('renankanu'))
        .thenAnswer((_) async => Right(resultUsers));

    final result = await usecase('renankanu');

    expect(result, Right<Failure, List<UserEntity>>(resultUsers));
    verify(repository.getUsers('renankanu'));
    verifyNoMoreInteractions((repository));
  });

  test('should return error ServerFailure get user by text from repository',
      () async {
    when(repository.getUsers('renankanu'))
        .thenAnswer((_) async => Left(ServerFailure()));

    final result = await usecase('renankanu');

    expect(result, Left(ServerFailure()));
    verify(repository.getUsers('renankanu'));
    verifyNoMoreInteractions((repository));
  });
}
