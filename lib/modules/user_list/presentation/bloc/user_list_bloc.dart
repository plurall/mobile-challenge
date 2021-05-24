import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_challenge/clean/exception.dart';
import 'package:mobile_challenge/clean/usecase.dart';
import 'package:mobile_challenge/modules/user_list/data/models/user_search_reponse_model.dart';
import 'package:mobile_challenge/modules/user_list/domain/usecases/get_new_page_user_search.dart';
import 'package:mobile_challenge/shared/entities/User.dart';
import 'package:mobile_challenge/modules/user_list/domain/usecases/get_default_user_list.dart';
import 'package:mobile_challenge/modules/user_list/domain/usecases/get_user_search.dart';
import 'package:mobile_challenge/modules/user_list/presentation/bloc/user_list_event.dart';
import 'package:mobile_challenge/modules/user_list/presentation/bloc/user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  final GetUserSearch getUserSearchUseCase;
  final GetDefaultUserList getDefaultUserListUseCase;
  final GetNewPageUserSearch getNewPageUserListUseCase;

  UserListBloc({
    @required GetUserSearch search,
    @required GetDefaultUserList empty,
    @required GetNewPageUserSearch newPage,
  })  : assert(search != null),
        assert(empty != null),
        assert(newPage != null),
        getUserSearchUseCase = search,
        getDefaultUserListUseCase = empty,
        getNewPageUserListUseCase = newPage,
        super(null);

  @override
  UserListState get initialState => Empty();

  @override
  Stream<UserListState> mapEventToState(
    UserListEvent event,
  ) async* {
    try {
      if (event is GetUserSearchEvent) {
        final input = event.query;
        yield Loading();

        final UserSearchResponseModel result =
            await getUserSearchUseCase(GetUserSearchParams(input));
        if (result.users.length == 0) {
          throw EmptyList();
        }
        yield Loaded(users: result.users, hasMore: result.hasMore);
      } else if (event is GetDefaultUserListEvent) {
        yield Loading();
        final UserSearchResponseModel result =
            await getDefaultUserListUseCase(NoParams());
        yield Loaded(users: result.users, hasMore: result.hasMore);
      } else if (event is GetNewPageUserSearchEvent) {
        final UserSearchResponseModel result =
            await getNewPageUserListUseCase(GetNewPageUserSearchParams(
          event.query,
          event.page,
        ));
        if (state is Loaded) {
          Loaded currentState = state;
          yield Loaded(
              users: currentState.users + result.users,
              hasMore: result.hasMore);
        } else {
          yield Loaded(users: result.users, hasMore: result.hasMore);
        }
      }
    } catch (err) {
      yield* _errorHandler(err);
    }
  }

  Stream<UserListState> _errorHandler(dynamic response) async* {
    if (response is AppExceptions) {
      yield Error(message: response.message, icon: response.icon);
    } else {
      yield Error(message: response.toString());
    }
  }
}
