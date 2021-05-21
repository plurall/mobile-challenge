import 'package:equatable/equatable.dart';
import 'package:mobile_challenge/core/constants/app_failures_messages.dart';
import 'package:mobile_challenge/core/domain/usecases/usecase.dart';
import 'package:mobile_challenge/features/github/domain/entities/user_entity.dart';
import 'package:mobile_challenge/features/github/domain/usecases/get_bookmarked_users_usecase.dart';
import 'package:mobile_challenge/features/github/domain/usecases/get_user_usecase.dart';
import 'package:mobile_challenge/features/github/domain/usecases/remove_user_from_bookmarks_usecase.dart';
import 'package:mobile_challenge/features/github/domain/usecases/save_user_usecase.dart';
import 'package:mobx/mobx.dart';
import 'package:meta/meta.dart';

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
  final GetUserUseCase getUserUseCase;
  final GetBookmarkUsersUseCase getBookmarkUsersUseCase;
  final SaveUserUseCase saveUserUseCase;
  final RemoveUserFromBookmarksUseCase removeUserFromBookmarksUseCase;

  _UserProfileStoreBase({
    @required this.getUserUseCase,
    @required this.getBookmarkUsersUseCase,
    @required this.saveUserUseCase,
    @required this.removeUserFromBookmarksUseCase,
  });

  @observable
  UserStatus userStatus = Idle();

  @observable
  UserEntity userEntity;

  @observable
  bool isSaved = false;

  @action
  Future<void> getUserInfo(String username) async {
    userStatus = Loading();
    final result = await getUserUseCase(username);

    result.fold(
      (l) => userStatus =
          Error(message: AppFailureMessages.SERVER_FAILURE_MESSAGE),
      (user) {
        userEntity = user;
        userStatus = Loaded();
      },
    );
  }

  @action
  Future<void> checkIfUserIsSaved(String username) async {
    final result = await getBookmarkUsersUseCase(NoParams());

    result.fold(
      (l) => isSaved = false,
      (usersEntity) {
        final index = usersEntity.users
            .indexWhere((element) => element.login == username);
        if (index != -1) {
          isSaved = true;
        }
      },
    );
  }

  @action
  Future<void> removeUserFromBookmarks(String username) async {
    await removeUserFromBookmarksUseCase(username);
  }

  @action
  Future<void> saveUser() async {
    await saveUserUseCase(userEntity);
  }
}
