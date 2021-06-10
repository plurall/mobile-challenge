import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../domain/use_cases/set_github_user_favorite.dart';
import 'github_user_or_user_details_event.dart';
import 'github_user_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';

class SetGithubUserFavoriteBloc
    extends Bloc<GithubUserOrUserDetailsEvent, GithubUserDetailsState> {
  final SetGithubUserFavorite setGithubUserFavorite;

  SetGithubUserFavoriteBloc({@required SetGithubUserFavorite usecase})
      : setGithubUserFavorite = usecase,
        super(Empty());
  @override
  Stream<GithubUserDetailsState> mapEventToState(
    GithubUserOrUserDetailsEvent event,
  ) async* {
    if (event is SetGitHubUserFavorites) {
      yield Loading();
      await setGithubUserFavorite(event.githubUserFavorite);
    }
  }
}
