import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/prefs_key.dart';
import '../../data/datasources/local_profile_datasource.dart';
import '../../data/models/user_detail_model.dart';
import '../../data/models/users_detail_model.dart';
import '../../domain/errors/profile_errors.dart';


class LocalProfileDatasourceImpl implements LocalProfileDatasource {
  final SharedPreferences prefs;

  LocalProfileDatasourceImpl(this.prefs);

  List<UserDetailModel> cachedUsers = [];
  @override
  Future<UserDetailModel> getUser(String username) async {
    _getCachedUsers();

    final index = cachedUsers.indexWhere((item) => item.login == username);
    if (index != -1) {
        return cachedUsers[index];
    }

    throw ProfileCacheException();
  }

  @override
  Future<void> cacheUser(UserDetailModel user) async {
    _getCachedUsers();

    final index = cachedUsers.indexWhere((item) => item.login == user.login);

    //update with fresh data
    if (index != -1) cachedUsers[index] = user;
    else cachedUsers.add(user);
    

    final newCachedUsers = UsersDetailModel(users: cachedUsers);
    final cachedUsersJson =  newCachedUsers.toJson();
    await prefs.setString(PrefsKey.CACHED_USERS, cachedUsersJson);
  }

  void _getCachedUsers() {
    final cachedUsersJson = prefs.getString(PrefsKey.CACHED_USERS);

    if (cachedUsersJson != null) {
        cachedUsers = UsersDetailModel.fromMap(json.decode(cachedUsersJson)).users;
    }
  }
  
}