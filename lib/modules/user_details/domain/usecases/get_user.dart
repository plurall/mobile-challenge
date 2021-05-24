import 'package:mobile_challenge/clean/usecase.dart';
import 'package:mobile_challenge/modules/user_details/data/repositories/github_user_api_repository.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

class GetUser implements UseCase<User, GetUserParams> {
  GetUser(this.githubRepo);

  final GithubUserApiRepositoryProtocol githubRepo;

  @override
  Future<User> call(GetUserParams params) async {
    return await githubRepo.getUser(params.nickname);
  }
}

class GetUserParams {
  GetUserParams(this.nickname);

  final String nickname;
}
