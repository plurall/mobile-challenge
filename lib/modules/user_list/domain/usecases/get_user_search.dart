import 'package:mobile_challenge/clean/usecase.dart';
import 'package:mobile_challenge/modules/user_list/data/models/user_search_reponse_model.dart';
import 'package:mobile_challenge/modules/user_list/data/repositories/github_search_api_repository.dart';

class GetUserSearch
    implements UseCase<UserSearchResponseModel, GetUserSearchParams> {
  GetUserSearch(this.githubRepo);

  final GithubSearchApiRepositoryProtocol githubRepo;

  @override
  Future<UserSearchResponseModel> call(GetUserSearchParams params) async {
    return await githubRepo.getUserSearch(params.query);
  }
}

class GetUserSearchParams {
  GetUserSearchParams(this.query);

  final String query;
}
