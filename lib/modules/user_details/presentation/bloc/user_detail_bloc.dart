import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_challenge/modules/user_details/domain/usecases/get_is_favorite.dart';
import 'package:mobile_challenge/modules/user_details/domain/usecases/get_user.dart';
import 'package:mobile_challenge/modules/user_details/domain/usecases/set_toggle_user_favorite.dart';
import 'package:mobile_challenge/modules/user_details/presentation/bloc/user_detail_event.dart';
import 'package:mobile_challenge/modules/user_details/presentation/bloc/user_detail_state.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

//TODO i18n
const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Input';

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
    print("User Detail called Event");
    print(event);
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
        print('isFavorite');
        print(updatedUser);
        yield Loaded(user: updatedUser);
      }
    } catch (err) {
      print(err);
      yield* _errorHandler(err);
    }
  }

  //TODO
  Stream<UserDetailState> _errorHandler(dynamic response) async* {
    //handle Error()
  }
}
