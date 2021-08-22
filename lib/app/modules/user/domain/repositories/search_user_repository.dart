import '../entities/user_detail_entity.dart';

abstract class SearchUserRepository {
  Future<List<UserDetailEntity>> search(String searchText);
}