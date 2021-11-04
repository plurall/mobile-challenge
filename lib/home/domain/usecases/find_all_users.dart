import 'package:mobile_challenge/home/data/service/github_service.dart';
import 'package:mobile_challenge/home/domain/entity/user.dart';

class FindAllUsers {
  final GithubService _githubService;

  FindAllUsers(this._githubService);

  Future<List<User>> execute(String searchQuery) async {
    return await _githubService.findAll(searchQuery);
  }
}
