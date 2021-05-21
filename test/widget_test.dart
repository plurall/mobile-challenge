import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/models/response/get_selected_user.model.dart';
import 'package:mobile_challenge/models/response/get_users_git.model.dart';
import 'package:mobile_challenge/services/interfaces/get_users_git.service.dart';

class MockClient implements GetUsersGitService {
  @override
  Future<GetSelectedUserModel> getSelectedUser(String user) async {
    return GetSelectedUserModel(
        avatar_url: 'url',
        bio: 'bio user',
        email: 'email',
        location: 'location',
        login: 'Robson');
  }

  @override
  Future<List<GetUsersGitModel>> getUsersGit(String user) async {
    return [
      GetUsersGitModel(avatar_url: 'teste_url', login: 'Robson'),
    ];
  }
}

class MockClientError implements GetUsersGitService {
  @override
  Future<GetSelectedUserModel> getSelectedUser(String user) async {
    return GetSelectedUserModel(
        avatar_url: 'url',
        bio: 'bio user',
        email: 'email',
        location: 'location',
        login: 'Robson');
  }

  @override
  Future<List<GetUsersGitModel>> getUsersGit(String user) async {
    return [];
  }
}

void main() {
  test("Sucesso ao solcitar dados ", () async {
    final model = MockClient();
    final result = await model.getSelectedUser('user');
    expect(result, isA<GetSelectedUserModel>());
  });
  test("Sucesso ao solcitar dados ", () async {
    final model = MockClient();
    final result = await model.getUsersGit('user');
    expect(result, isA<List<GetUsersGitModel>>());
  });
  test("Erro ao solcitar dados ", () async {
    final model = MockClientError();
    final result = await model.getUsersGit('user');
    expect(result, isA<List<GetUsersGitModel>>());
  });
}
