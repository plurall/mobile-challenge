import 'package:mobile_challenge/app/modules/search/infra/datasources/search_user_datasource.dart';

import '../../domain/entities/searched_user_entity.dart';
import '../../domain/repositories/search_user_repository.dart';

class SearchUserRepositoryImpl implements SearchUserRepository {
  final SearchUserDataSource dataSource;

  SearchUserRepositoryImpl(this.dataSource);
  @override
  Future<List<SearchedUserEntity>> search(String searchText) async{
   final result = await dataSource.search(searchText);
   final users = result.map((item) => item.toEntity()).toList();
   return users;
  }
}