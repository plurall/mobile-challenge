import 'package:mobile_challenge/clean/usecase.dart';
import 'package:mobile_challenge/modules/user_list/data/models/user_search_reponse_model.dart';
import 'package:mobile_challenge/modules/user_list/data/repositories/github_search_api_repository.dart';

class GetNewPageUserSearch
    implements UseCase<UserSearchResponseModel, GetNewPageUserSearchParams> {
  GetNewPageUserSearch(this.githubRepo);

  final GithubSearchApiRepositoryProtocol githubRepo;

  @override
  Future<UserSearchResponseModel> call(
      GetNewPageUserSearchParams params) async {
    return await githubRepo.getNextPageUserSearch(params.query, params.page);
  }
}

class GetNewPageUserSearchParams {
  GetNewPageUserSearchParams(this.query, this.page);

  final String query;
  final int page;
}
