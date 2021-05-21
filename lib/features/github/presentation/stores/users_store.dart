import 'package:equatable/equatable.dart';
import 'package:mobile_challenge/core/constants/app_failures_messages.dart';
import 'package:mobile_challenge/core/errors/failures.dart';
import 'package:mobile_challenge/features/github/domain/entities/users_entity.dart';
import 'package:mobile_challenge/features/github/domain/usecases/get_users_with_name_usecase.dart';
import 'package:mobx/mobx.dart';
part 'users_store.g.dart';

abstract class UsersStatus extends Equatable {
  @override
  List<Object> get props => [];
}

class Idle extends UsersStatus {}

class Loading extends UsersStatus {}

class Loaded extends UsersStatus {}

class Error extends UsersStatus {
  final String message;

  Error({this.message});

  @override
  List<Object> get props => [message];
}

class UsersStore = _UsersStoreBase with _$UsersStore;

abstract class _UsersStoreBase with Store {
  final GetUsersWithNameUseCase _getUsersWithNameUseCase;

  _UsersStoreBase(this._getUsersWithNameUseCase);

  @observable
  UsersStatus status = Idle();

  @observable
  UsersEntity users;

  @action
  Future<void> getUsersWithName(String name) async {
    if (name.isEmpty) {
      status = Error(message: AppFailureMessages.INVALID_INPUT_FAILURE);
      return;
    }
    status = Loading();
    final result = await _getUsersWithNameUseCase(name);

    result.fold(
      (failure) {
        status = failure is OfflineFailure
            ? Error(message: AppFailureMessages.NO_INTERNET_CONNECTION)
            : Error(message: AppFailureMessages.SERVER_FAILURE);
      },
      (newUsers) {
        users = newUsers;
        status = Loaded();
      },
    );
  }
}
