import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/user/features/search/domain/entities/searched_user_entity.dart';
import 'package:mobile_challenge/app/modules/user/features/search/infra/datasources/search_user_datasource.dart';
import 'package:mobile_challenge/app/modules/user/features/search/infra/models/searched_user_model.dart';
import 'package:mobile_challenge/app/modules/user/features/search/infra/repositories/search_user_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class SearchUserDataSourceMock extends Mock implements SearchUserDataSource{}
void main() {

  test('Should return a list of SearchedUser', () async {
    final searchText = "random_text";
    final datasource = SearchUserDataSourceMock();
    final repository = SearchUserRepositoryImpl(datasource);
    when(() => datasource.search(searchText)).thenAnswer((_) async => <SearchedUserModel>[]);

    final result = await repository.search(searchText);

    expect(result, isA<List<SearchedUserEntity>>());
  });
}