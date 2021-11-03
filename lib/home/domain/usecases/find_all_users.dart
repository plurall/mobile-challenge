import 'package:mobile_challenge/home/data/service/github_service.dart';
import 'package:mobile_challenge/home/domain/entity/user.dart';

class FindAllUsers {
  final GithubService _githubService;

  FindAllUsers(this._githubService);

  Future<List<User>> findAll(String searchQuery) async {
    try {
      return await _githubService.findAll(searchQuery);
    } catch (e) {
      throw e;
    }
  }
}
