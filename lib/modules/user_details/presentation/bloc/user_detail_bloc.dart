import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_challenge/clean/exception.dart';
import 'package:mobile_challenge/modules/user_details/domain/usecases/get_is_favorite.dart';
import 'package:mobile_challenge/modules/user_details/domain/usecases/get_user.dart';
import 'package:mobile_challenge/modules/user_details/domain/usecases/set_toggle_user_favorite.dart';
import 'package:mobile_challenge/modules/user_details/presentation/bloc/user_detail_event.dart';
import 'package:mobile_challenge/modules/user_details/presentation/bloc/user_detail_state.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final GetUser getUserUseCase;
  final GetIsFavorite isFavoriteUseCase;
  final SetToggleUserFavorite toggleFavoriteUseCase;

  UserDetailBloc({
    @required GetUser getUser,
    @required GetIsFavorite isFavorite,
    @required SetToggleUserFavorite toggleFavorite,
  })  : assert(getUser != null),
        assert(isFavorite != null),
        assert(toggleFavorite != null),
        getUserUseCase = getUser,
        isFavoriteUseCase = isFavorite,
        toggleFavoriteUseCase = toggleFavorite,
        super(null);

  @override
  UserDetailState get initialState => Empty();

  @override
  Stream<UserDetailState> mapEventToState(
    UserDetailEvent event,
  ) async* {
    try {
      if (event is GetUserEvent) {
        yield Loading();
        final User result = await getUserUseCase(GetUserParams(event.nickname));
        final bool isUserFavorite =
            await isFavoriteUseCase(GetIsFavoriteParams(event.nickname));
        result.favorite = isUserFavorite;
        yield Loaded(user: result);
      } else if (event is GetToggleFavoriteEvent) {
        final User updatedUser = await toggleFavoriteUseCase(
            SetToggleUserFavoriteParams(event.user));
        yield Loaded(user: updatedUser);
      } else if (event is FillUserEvent) {
        yield Loaded(user: event.user);
      }
    } catch (err) {
      yield* _errorHandler(err);
    }
  }

  Stream<UserDetailState> _errorHandler(dynamic response) async* {
    if (response is AppExceptions) {
      yield Error(message: response.message, icon: response.icon);
    } else {
      yield Error(message: response.toString());
    }
  }
}
