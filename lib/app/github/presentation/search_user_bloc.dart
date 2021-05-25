import 'package:bloc/bloc.dart';
import 'package:mobile_challenge/app/github/domain/use_cases/github_search_by_user_name.dart';
import 'state/state.dart';

class SearchUserBloc extends Bloc<String, GitHubState> {
  final GitHubSearchByUserName usecase;

  SearchUserBloc(
    this.usecase,
  ) : super(GitHubLoading());

  @override
  Stream<GitHubState> mapEventToState(String searchUserName) async* {
    final result = await usecase.user(searchUserName);
    yield result.fold((l) => GitHubError(l), (r) => GitHubUserSuccess(r));
  }
}
