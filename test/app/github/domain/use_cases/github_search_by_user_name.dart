import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/github/domain/entities/github_result_search_entitie.dart';
import 'package:mobile_challenge/app/github/domain/errors/errors.dart';
import 'package:mobile_challenge/app/github/domain/repositories/github_search_repository.dart';
import 'package:mobile_challenge/app/github/domain/use_cases/github_search_by_user_name.dart';
import 'package:mocktail/mocktail.dart';

class MockGithubSearchRepository extends Mock
    implements GithubSearchRepository {}

void main() {
  late MockGithubSearchRepository repository;
  late GitHubSearchByUserNameImpl usecase;

  setUp(() {
    repository = MockGithubSearchRepository();
    usecase = GitHubSearchByUserNameImpl(repository);
  });

  final tUserName = 'user-test';
  final tUserList = <GitHubResultSearch>[];

  test('should, return a list of results search', () async {
    when(() => repository.search(tUserName))
        .thenAnswer((_) async => Right(tUserList));

    final result = await usecase(tUserName);

    expect(result.isLeft(), false);
    expect(result, Right(tUserList));
  });

  test('should, return a InvalidTextError case text invalid', () async {
    when(() => repository.search('test'))
        .thenAnswer((_) async => Right(tUserList));

    var result = await usecase(null);

    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<InvalidTextError>());

    result = await usecase('');
    expect(result.fold(id, id), isA<InvalidTextError>());
  });
}
