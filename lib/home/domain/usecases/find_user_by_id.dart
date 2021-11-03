import 'package:mobile_challenge/home/data/service/github_service.dart';
import 'package:mobile_challenge/home/domain/entity/user.dart';

class FindUserById {
  final GithubService _githubService;

  FindUserById(this._githubService);

  Future<User> findUserById(int id) async {
    try {
      return await _githubService.findById(id);
    } catch (e) {
      throw e;
    }
  }
}
