import 'package:equatable/equatable.dart';
import 'package:mobile_challenge/core/constants/app_failures_messages.dart';
import 'package:mobile_challenge/features/github/domain/entities/user_entity.dart';
import 'package:mobile_challenge/features/github/domain/usecases/get_user_usecase.dart';
import 'package:mobx/mobx.dart';
part 'user_profile_store.g.dart';

abstract class UserStatus extends Equatable {
  @override
  List<Object> get props => [];
}

class Idle extends UserStatus {}

class Loading extends UserStatus {}

class Loaded extends UserStatus {}

class Error extends UserStatus {
  final String message;

  Error({this.message});

  @override
  List<Object> get props => [message];
}

class UserProfileStore = _UserProfileStoreBase with _$UserProfileStore;

abstract class _UserProfileStoreBase with Store {
  final GetUserUseCase _getUserUseCase;

  _UserProfileStoreBase(this._getUserUseCase);

  @observable
  UserStatus userStatus = Idle();

  @observable
  UserEntity userEntity;

  @action
  Future<void> getUserInfo(String username) async {
    userStatus = Loading();
    final result = await _getUserUseCase(username);

    result.fold(
      (l) => userStatus =
          Error(message: AppFailureMessages.SERVER_FAILURE_MESSAGE),
      (user) {
        userEntity = user;
        userStatus = Loaded();
      },
    );
  }
}
