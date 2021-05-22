import 'package:mobile_challenge/clean/usecase.dart';
import 'package:mobile_challenge/modules/user_list/data/repositories/github_api_repository.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

class GetUserSearch implements UseCase<List<User>, GetUserSearchParams> {
  GetUserSearch(this.githubRepo);

  final GithubApiRepositoryProtocol githubRepo;

  @override
  Future<List<User>> call(GetUserSearchParams params) async {
    return await githubRepo.getUserSearch(params.query);
  }
}

class GetUserSearchParams {
  GetUserSearchParams(this.query);

  final String query;

  @override
  List<Object> get props => [];
}
