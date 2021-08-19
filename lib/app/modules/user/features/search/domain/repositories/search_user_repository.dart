import '../entities/searched_user_entity.dart';

abstract class SearchUserRepository {
  Future<List<SearchedUserEntity>> search(String searchText);
}