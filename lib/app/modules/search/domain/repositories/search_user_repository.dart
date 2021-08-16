import 'package:mobile_challenge/app/modules/search/domain/entities/searched_user.dart';

abstract class SearchUserRepository {
  Future<List<SearchedUser>> search(String searchText);
}