import 'package:mobile_challenge/data/models/user.dart';

abstract class SearchRemoteInterface {
  Future<List<User>> getUsers(String search);
  Future<User> getUser(String login);
}
