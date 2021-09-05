
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/core/errors/errors.dart';
import 'package:mobile_challenge/app/modules/user_search/domain/entities/user.dart';
import 'package:mobile_challenge/app/modules/user_search/domain/repositories/user_repository.dart';
import 'package:mobile_challenge/app/modules/user_search/domain/usecases/search_by_user_login.dart';
import 'package:mockito/mockito.dart';

class UserSearchRepositoryMock extends Mock implements UserSearchRepository {}

void main(){
  final repository = UserSearchRepositoryMock();
  final usecase = SearchByUserLoginImpl(repository);

  test('Must return a UserSearch', () async {
    when(repository.search(any))
        .thenAnswer((_) async => Right(
        UserSearch(
          id: 14909648,
          login: "fajusto",
          name: "Fabrício Justo",
          avatar: "https://avatars.githubusercontent.com/u/14909648?v=4",
          location: null,
          email: null,
          bio: "I’m a self learner, technology lover, and enjoy coding too much.",
        )
    ));

    final result = await usecase('fajusto');
    expect(result | null, isA<UserSearch>());
  });

  test('Must return an exception if it is an invalid text', () async {
    when(repository.search(any))
        .thenAnswer((_) async => Right(UserSearch(
      id: 14909648,
      login: "fajusto",
      name: "Fabrício Justo",
      avatar: "https://avatars.githubusercontent.com/u/14909648?v=4",
      location: null,
      email: null,
      bio: "I’m a self learner, technology lover, and enjoy coding too much.",
    )));
    var result = await usecase(null);
    expect(result.fold(id, id), isA<InvalidTextError>());
  });
}