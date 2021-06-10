import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/features/github_user/domain/entities/github_user.dart';
import 'package:mobile_challenge/app/features/github_user/domain/repositories/github_search_repository.dart';
import 'package:mobile_challenge/app/features/github_user/domain/use_cases/get_github_user_list.dart';

import 'package:mocktail/mocktail.dart';

class MockGithubSearchRepository extends Mock implements GithubUserRepository {}

void main() {
  MockGithubSearchRepository repository;
  GithubUserList usecase;

  setUp(() {
    repository = MockGithubSearchRepository();
    usecase = GithubUserList(repository);
  });

  final tUserName = 'user-test';
  final tUserList = <GithubUser>[];

  test('should, return a list of results search', () async {
    when(() => repository.getGithubUsers(tUserName))
        .thenAnswer((_) async => Right(tUserList));

    final result = await usecase(Params(userName: tUserName));

    expect(result.isLeft(), false);
    expect(result, Right(tUserList));
  });
}
