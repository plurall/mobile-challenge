import 'package:mobile_challenge/app/modules/search/domain/entities/searched_user_entity.dart';

abstract class SearchUserRepository {
  Future<List<SearchedUserEntity>> search(String searchText);
}