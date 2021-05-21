import 'package:mobile_challenge/models/response/get_selected_user.model.dart';
import 'package:mobile_challenge/models/response/get_users_git.model.dart';

abstract class GetUsersGitService {
  Future<List<GetUsersGitModel>> getUsersGit(String user);
  Future<GetSelectedUserModel> getSelectedUser(String user);
}
