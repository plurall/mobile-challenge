import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_challenge/clean/usecase.dart';
import 'package:mobile_challenge/modules/favorites/domain/usecases/get_favorite_list.dart';
import 'package:mobile_challenge/modules/favorites/presentation/bloc/favorites_event.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

import 'favorites_state.dart';

//TODO i18n
const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Input';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavoriteList useCase;

  FavoritesBloc({
    @required GetFavoriteList useCase,
  })  : assert(useCase != null),
        useCase = useCase,
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
        final List<User> result = await useCase(NoParams());
        yield Loaded(users: result);
      } catch (err) {
        yield* _errorHandler(err);
      }
    }
  }

  //TODO
  Stream<FavoritesState> _errorHandler(dynamic response) async* {
    //handle Error()
  }
}
