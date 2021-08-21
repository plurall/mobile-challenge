import '../entities/searched_user_entity.dart';
import '../errors/search_errors.dart';
import '../repositories/search_user_repository.dart';

abstract class SearchUser {
  Future<List<SearchedUserEntity>> call(String searchText);
}

class SearchUserImpl implements SearchUser{
  final SearchUserRepository repository;

  SearchUserImpl(this.repository);
  @override
  Future<List<SearchedUserEntity>> call(String searchText) async {
    if (searchText.isEmpty) {
        throw InvalidSearchText();
    }
    
    final result = await repository.search(searchText);
    return result;
  }
}