import 'package:mobile_challenge/app/modules/search/domain/repositories/search_user_repository.dart';

import '../entities/searched_user.dart';

abstract class SearchUser {
  Future<List<SearchedUser>> search(String searchText);
}

class SearchUserImpl implements SearchUser{
  final SearchUserRepository repository;

  SearchUserImpl(this.repository);
  @override
  Future<List<SearchedUser>> search(String searchText) async {
    final result = await repository.search(searchText);
    return result;
  }

}