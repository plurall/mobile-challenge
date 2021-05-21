import 'package:equatable/equatable.dart';
import 'package:mobile_challenge/core/constants/app_failures_messages.dart';
import 'package:mobile_challenge/core/domain/usecases/usecase.dart';
import 'package:mobile_challenge/features/github/domain/entities/users_entity.dart';
import 'package:mobile_challenge/features/github/domain/usecases/get_bookmarked_users_usecase.dart';
import 'package:mobx/mobx.dart';
import 'package:meta/meta.dart';

part 'bookmarks_store.g.dart';

abstract class BookmarksStatus extends Equatable {
  @override
  List<Object> get props => [];
}

class Idle extends BookmarksStatus {}

class Loading extends BookmarksStatus {}

class Loaded extends BookmarksStatus {}

class Error extends BookmarksStatus {
  final String message;

  Error({this.message});

  @override
  List<Object> get props => [message];
}

class BookmarksStore = _BookmarksStoreBase with _$BookmarksStore;

abstract class _BookmarksStoreBase with Store {
  final GetBookmarkUsersUseCase getBookmarkUsersUseCase;

  _BookmarksStoreBase({
    @required this.getBookmarkUsersUseCase,
  });

  @observable
  BookmarksStatus bookmarksStatus = Idle();

  @observable
  UsersEntity usersEntity = UsersEntity(users: []);

  @action
  Future<void> getBookmarkedUsers() async {
    bookmarksStatus = Loading();

    final result = await getBookmarkUsersUseCase(NoParams());

    result.fold(
      (l) {
        usersEntity = UsersEntity(users: []);
        bookmarksStatus = Error(message: AppFailureMessages.NO_USER_CACHED);
      },
      (users) {
        usersEntity = users;
        bookmarksStatus = Loaded();
      },
    );
  }
}
