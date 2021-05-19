import 'package:mobile_challenge/features/github/data/models/user_model.dart';
import 'package:mobile_challenge/features/github/data/models/users_model.dart';

abstract class GithubLocalDataSource {
  Future<UsersModel> getBookmarkedUsers();
  Future<UserModel> getCachedUser(String username);
  
  Future<void> cacheUser(UserModel userToCache);
}