import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../../../core/errors/errors.dart';
import '../../domain/entities/user.dart';
import '../../infra/cache/local_storage/local_storage.dart';
import '../../infra/drivers/users_driver.dart';
import '../models/user_model.dart';

@LazySingleton(as: UsersDriver)
class UsersDriverImpl implements UsersDriver {
  final LocalStorage localStorage;

  UsersDriverImpl(this.localStorage);

  final _usersFavoritesKey = 'USERS_FAVORITES_KEY';

  @override
  Future<List<User>> getFavoritesUsers() async {
    try {
      final result = await localStorage.read(_usersFavoritesKey);
      if (result != null) {
        final resultDecoded = jsonDecode(result);
        final data = resultDecoded
            .map<User>((item) => UserModel.fromJson(item))
            .toList();
        return data;
      } else {
        return <User>[];
      }
    } catch (error) {
      throw CacheError();
    }
  }

  @override
  Future<bool> saveFavoritesUser(User user) async {
    try {
      final users = await getFavoritesUsers();
      if (users.contains(user)) {
        users.remove(user);
      } else {
        users.add(user);
      }
      final usersEncoded = jsonEncode(
        users.map((user) => (user as UserModel).toJson()).toList(),
      );
      await localStorage.write(_usersFavoritesKey, usersEncoded);
      return true;
    } catch (error) {
      throw CacheError(message: 'Erro ao tentar favoritar.');
    }
  }
}
