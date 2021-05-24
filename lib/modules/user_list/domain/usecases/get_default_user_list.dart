import 'package:mobile_challenge/clean/usecase.dart';
import 'package:mobile_challenge/modules/user_list/data/models/user_search_reponse_model.dart';
import 'package:mobile_challenge/modules/user_list/data/repositories/github_search_api_repository.dart';

class GetDefaultUserList implements UseCase<UserSearchResponseModel, NoParams> {
  GetDefaultUserList(this.githubRepo);

  final GithubSearchApiRepositoryProtocol githubRepo;

  @override
  Future<UserSearchResponseModel> call(NoParams params) async {
    return await githubRepo.getDefaultUserList();
  }
}
