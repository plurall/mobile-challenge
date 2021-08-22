import '../entities/user_entity.dart';

abstract class SearchUserRepository {
  Future<List<UserEntity>> search(String searchText);
}