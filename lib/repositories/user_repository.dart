import 'package:mobile_challenge/interfaces/http_client_interface.dart';
import 'package:mobile_challenge/interfaces/repository_interface.dart';
import 'package:mobile_challenge/models/search_model.dart';
import 'package:mobile_challenge/models/user_model.dart';

class UserRepository extends IRepository {
  UserRepository(IHttpClient client) : super(client);

  Future<SearchModel> searchAUser(String query, [int page = 1]) async {
    try {
      var response = await client.get('/search/users?q=$query&page=$page');
      return SearchModel.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> fetchUser(String username) async {
    try {
      var response = await client.get('/users/$username');
      return UserModel.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }
}
