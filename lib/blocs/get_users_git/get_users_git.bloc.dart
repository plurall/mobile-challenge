import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_challenge/models/response/get_selected_user.model.dart';
import 'package:mobile_challenge/models/response/get_users_git.model.dart';
import 'package:mobile_challenge/models/user_storage.model.dart';
import 'package:mobile_challenge/services/interfaces/get_users_git.service.dart';
import 'package:mobile_challenge/utils/disposeable.dart';
import 'package:mobile_challenge/utils/locator.dart';
import 'package:mobile_challenge/utils/user_storage.mixin.dart';
import 'package:rxdart/rxdart.dart';

class GetUsersGitBloc with UserStorageMixin implements Disposeable {
  GetUsersGitBloc() {
    getAllUsers();
  }

  final _getUsersService = locator<GetUsersGitService>();

  final _allUsersController = BehaviorSubject<List<GetUsersGitModel>>();
  final _selectedUserController = BehaviorSubject<GetSelectedUserModel>();
  final _listLocalUsersontroller = BehaviorSubject<List<UserStorageModel>>();
  final _searchUserController = BehaviorSubject<String>.seeded('');

  Stream<List<GetUsersGitModel>> get allUsers$ => _allUsersController.stream;
  Stream<GetSelectedUserModel> get selectedUser$ =>
      _selectedUserController.stream;
  Stream<String> get searchInput$ => _searchUserController.stream;
  Stream<List<UserStorageModel>> get listLocalUsers$ =>
      _listLocalUsersontroller.stream;

  get onChangeSearchUser => _searchUserController.add;

  Future getAllUsers() async {
    try {
      String user = _searchUserController.value;
      final response = await _getUsersService.getUsersGit(user);
      _allUsersController.add(response);
    } catch (e) {
      _allUsersController.addError(e);
    }
  }

  Future getSelectedUser(String user) async {
    try {
      final response = await _getUsersService.getSelectedUser(user);
      _selectedUserController.add(response);
    } catch (e) {
      _selectedUserController.addError(e);
    }
  }

  void clearSelectedUser() {
    _selectedUserController.add(null);
  }

  Future<bool> saveFavoriteUser(GetSelectedUserModel user) async {
    final favorites = await readFavoritesUsersList();
    final userToStore = UserStorageModel(
      bio: user.bio,
      email: user.email,
      location: user.location,
      login: user.login,
    );
    if (favorites != null && favorites.isNotEmpty) {
      final containsUser = favorites.firstWhere(
        (item) => item.login == user.login,
        orElse: () => null,
      );
      if (containsUser == null) {
        await saveToStorage(userToStore);
        return true;
      } else
        return false;
    } else
      saveToStorage(userToStore);
    return true;
  }

  Future<void> loadLocalFavoritedUsers() async {
    final storage = locator<FlutterSecureStorage>();
    try {
      final favorites = await readFavoritesUsersList();
      if (favorites != null && favorites.isNotEmpty) {
        _listLocalUsersontroller.add(favorites);
      } else
        _listLocalUsersontroller.add(null);
    } catch (e) {
      await storage.delete(key: 'favoriteUsers');
    }
  }

  Future<void> removeLocalUser(String login) async {
    if (login != null) {
      await removeToStorage(login);
      loadLocalFavoritedUsers();
    }
  }

  @override
  void dispose() {
    _allUsersController?.close();
    _selectedUserController?.close();
    _listLocalUsersontroller?.close();
    _searchUserController?.close();
  }
}
