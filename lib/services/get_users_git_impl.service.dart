import 'dart:convert';
import 'dart:io';
import 'package:mobile_challenge/models/response/get_selected_user.model.dart';
import 'package:mobile_challenge/models/response/get_users_git.model.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_challenge/services/interfaces/get_users_git.service.dart';

class GetUsersGitServiceImpl implements GetUsersGitService {
  @override
  Future<List<GetUsersGitModel>> getUsersGit(String user) async {
    final response = await http.get(
        Uri.https('api.github.com', 'search/users', {'q': user + 'in:user'}));
    final decodedJson = jsonDecode(response.body);
    final result = (decodedJson['items'] as List)
        .map((item) => GetUsersGitModel.fromJson(item))
        .toList();

    return result;
  }

  Future<GetSelectedUserModel> getSelectedUser(String user) async {
    final response =
        await http.get(Uri.https('api.github.com', 'users/' + user));
    final decodedJson = jsonDecode(response.body);
    final result = GetSelectedUserModel.fromJson(decodedJson);

    return result;
  }
}
