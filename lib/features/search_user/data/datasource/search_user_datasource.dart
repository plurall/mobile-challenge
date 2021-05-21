import 'package:mobile_challenge/features/search_user/data/models/user_model.dart';

abstract class SearchDatasource {
  Future<List<UserModel>> searchText(String textSearch);
}
