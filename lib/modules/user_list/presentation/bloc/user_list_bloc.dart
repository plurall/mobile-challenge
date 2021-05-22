import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_challenge/clean/usecase.dart';
import 'package:mobile_challenge/modules/user_list/domain/entities/User.dart';
import 'package:mobile_challenge/modules/user_list/domain/usecases/get_default_user_list.dart';
import 'package:mobile_challenge/modules/user_list/domain/usecases/get_user_search.dart';
import 'package:mobile_challenge/modules/user_list/presentation/bloc/user_list_event.dart';
import 'package:mobile_challenge/modules/user_list/presentation/bloc/user_list_state.dart';

//TODO i18n
const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Input';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final GetUserSearch getUserSearchUseCase;
  final GetDefaultUserList getDefaultUserListUseCase;

  UserListBloc({
    @required GetUserSearch search,
    @required GetDefaultUserList empty,
  })  : assert(search != null),
        assert(empty != null),
        getUserSearchUseCase = search,
        getDefaultUserListUseCase = empty,
        super(null);

  @override
  UserListState get initialState => Empty();

  @override
  Stream<UserListState> mapEventToState(
    UserListEvent event,
  ) async* {
    if (event is GetUserSearchEvent) {
      final input = event.query;
      yield Loading();
      try {
        final List<User> result =
            await getUserSearchUseCase(GetUserSearchParams(input));
        yield Loaded(users: result);
      } catch (err) {
        yield* _errorHandler(err);
      }
    } else if (event is GetDefaultUserListEvent) {
      yield Loading();
      try {
        final result = await getDefaultUserListUseCase(NoParams());
        yield Loaded(users: result);
      } catch (err) {
        yield* _errorHandler(err);
      }
    }
  }

  //TODO
  Stream<UserListState> _errorHandler(dynamic response) async* {
    //handle Error()
  }
}
