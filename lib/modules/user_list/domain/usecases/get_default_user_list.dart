import 'package:mobile_challenge/clean/usecase.dart';
import 'package:mobile_challenge/modules/user_list/data/repositories/github_api_repository.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

class GetDefaultUserList implements UseCase<List<User>, NoParams> {
  GetDefaultUserList(this.githubRepo);

  final GithubApiRepositoryProtocol githubRepo;

  @override
  Future<List<User>> call(NoParams params) async {
    return await githubRepo.getDefaultUserList();
  }
}
