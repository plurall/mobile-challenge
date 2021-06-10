import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../domain/use_cases/get_github_user_details.dart';
import 'github_user_or_user_details_event.dart';
import 'github_user_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';

class GithubUserDetailsBloc
    extends Bloc<GithubUserOrUserDetailsEvent, GithubUserDetailsState> {
  final GitHubUserDetails getGitHubUserDetails;

  GithubUserDetailsBloc({@required GitHubUserDetails usecase})
      : getGitHubUserDetails = usecase,
        super(Empty());

  @override
  Stream<GithubUserDetailsState> mapEventToState(
    GithubUserOrUserDetailsEvent event,
  ) async* {
    if (event is GetGitHubUserOrUserDetails) {
      yield Loading();
      final failureOrGitHubUser = await getGitHubUserDetails
          .call(Params(userName: event.gitHubUserName));
      yield failureOrGitHubUser.fold(
        (failure) => Error(message: SERVER_FAILURE_MESSAGE),
        (gitHubUser) => Loaded(user: gitHubUser),
      );
    }
  }
}
