import 'package:mobile_challenge/features/github/data/models/user_model.dart';
import 'package:mobile_challenge/features/github/data/models/users_model.dart';

abstract class GithubRemoteDataSource {
  Future<UsersModel> getUsersWithName(String name);
  Future<UserModel> getUser(String username);
}