import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_github_user_favorite.dart';
import 'github_user_favorite_event.dart';
import 'github_user_favorite_state.dart';

const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class GithubUserFavoriteBloc
    extends Bloc<GithubUserFavoriteEvent, GithubUserFavoriteState> {
  final GetGithubUserFavorite _getGithubUserFavorite;

  GithubUserFavoriteBloc({@required GetGithubUserFavorite usecase})
      : _getGithubUserFavorite = usecase,
        super(Empty());

  @override
  Stream<GithubUserFavoriteState> mapEventToState(
    GithubUserFavoriteEvent event,
  ) async* {
    if (event is GetGithubUsersFavorites) {
      yield Loading();
      final failureOrFavorite = await _getGithubUserFavorite(NoParams());
      yield failureOrFavorite.fold(
        (failure) => Error(message: CACHE_FAILURE_MESSAGE),
        (favorite) => Loaded(favorite: favorite),
      );
    }
  }
}
