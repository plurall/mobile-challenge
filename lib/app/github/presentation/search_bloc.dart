import 'package:bloc/bloc.dart';
import 'package:mobile_challenge/app/github/domain/use_cases/github_search_by_user_name.dart';
import 'package:mobile_challenge/app/github/presentation/state/state.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<String, GitHubState> {
  final GitHubSearchByUserName usecase;

  SearchBloc(
    this.usecase,
  ) : super(GitHubStart());

  @override
  Stream<GitHubState> mapEventToState(String searchUserName) async* {
    yield GitHubLoading();
    final result = await usecase(searchUserName);
    yield result.fold((l) => GitHubError(l), (r) => GitHubSuccess(r));
  }

  @override
  Stream<Transition<String, GitHubState>> transformEvents(Stream<String> events,
      TransitionFunction<String, GitHubState> transitionFn) {
    return super.transformEvents(
        events.debounceTime(
          Duration(
            milliseconds: 900,
          ),
        ),
        transitionFn);
  }
}
