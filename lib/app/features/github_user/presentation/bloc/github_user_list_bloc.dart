import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/use_cases/get_github_user_list.dart';
import 'github_user_or_user_details_event.dart';
import 'github_users_list_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';

class GithubUserListBloc
    extends Bloc<GithubUserOrUserDetailsEvent, GithubUsersListState> {
  final GithubUserList getGithubUserList;

  GithubUserListBloc({@required GithubUserList usecase})
      : getGithubUserList = usecase,
        super(Empty());

  @override
  Stream<GithubUsersListState> mapEventToState(
    GithubUserOrUserDetailsEvent event,
  ) async* {
    if (event is GetGitHubUserOrUserDetails) {
      try {
        yield Loading();
        final failureOrGitHubUser =
            await getGithubUserList(Params(userName: event.gitHubUserName));
        yield failureOrGitHubUser.fold(
          (failure) => Error(message: SERVER_FAILURE_MESSAGE),
          (gitHubUserList) => Loaded(users: gitHubUserList),
        );
      } catch (e) {
        yield Empty();
      }
    }
  }

  @override
  Stream<Transition<GithubUserOrUserDetailsEvent, GithubUsersListState>>
      transformEvents(
          Stream<GithubUserOrUserDetailsEvent> events,
          TransitionFunction<GithubUserOrUserDetailsEvent, GithubUsersListState>
              transitionFn) {
    return super.transformEvents(
        events.debounceTime(
          Duration(
            milliseconds: 900,
          ),
        ),
        transitionFn);
  }
}
