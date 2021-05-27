import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_challenge/clean/exception.dart';
import 'package:mobile_challenge/clean/usecase.dart';
import 'package:mobile_challenge/modules/favorites/domain/usecases/get_favorite_list.dart';
import 'package:mobile_challenge/modules/favorites/presentation/bloc/favorites_event.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavoriteList favoritesUseCase;

  FavoritesBloc({
    @required GetFavoriteList favoritesUseCase,
  })  : assert(favoritesUseCase != null),
        favoritesUseCase = favoritesUseCase,
        super(null);

  @override
  FavoritesState get initialState => Empty();

  @override
  Stream<FavoritesState> mapEventToState(
    FavoritesEvent event,
  ) async* {
    if (event is GetFavoritesEvent) {
      yield Loading();
      try {
        final List<User> result = await favoritesUseCase(NoParams());
        yield Loaded(users: result);
      } catch (err) {
        yield* _errorHandler(err);
      }
    }
  }

  Stream<FavoritesState> _errorHandler(dynamic response) async* {
    if (response is AppExceptions) {
      yield Error(message: response.message, icon: response.icon);
    } else {
      yield Error(message: response.toString());
    }
  }
}
