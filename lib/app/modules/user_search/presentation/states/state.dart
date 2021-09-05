import 'package:mobile_challenge/app/core/errors/errors.dart';
import 'package:mobile_challenge/app/modules/user_search/domain/entities/user.dart';

abstract class UserSearchState {}

class UserSearchSuccess implements UserSearchState {
  final UserSearch userSearch;

  UserSearchSuccess(this.userSearch);
}

class UserSearchStart implements UserSearchState {}

class UserSearchLoading implements UserSearchState {}

class UserSearchError implements UserSearchState {
  final FailureSearch error;

  UserSearchError(this.error);
}