import '../models/searched_user_model.dart';

abstract class SearchUserDataSource {
  Future<List<SearchedUserModel>> search(String searchText);
}