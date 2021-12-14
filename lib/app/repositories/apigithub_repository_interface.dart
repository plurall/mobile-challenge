import 'package:mobile_challenge/app/models/user_model.dart';
import 'package:mobile_challenge/app/models/users_model.dart';

abstract class IApiGithub {
  Future<UserModel> findOne(String login);
  Future<List<UsersModel>> findAll(String login);
}
