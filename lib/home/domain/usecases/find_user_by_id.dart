import 'package:mobile_challenge/home/data/service/github_service.dart';
import 'package:mobile_challenge/home/domain/entity/user.dart';

class FindUserById {
  final GithubService _githubService;

  FindUserById(this._githubService);

  Future<User> execute(int id) async {
      return await _githubService.findById(id);
  }
}
