import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage_interface.dart';

class LocalStorageService implements ILocaStorage {
  final Future<SharedPreferences> sharedPreferences;
  LocalStorageService(this.sharedPreferences);

  @override
  Future delete(String key) async {
    var shared = await sharedPreferences;
    await shared.remove(key);
  }

  @override
  Future<List<String>> getStringList(String key) async {
    var shared = await sharedPreferences;
    return shared.getStringList(key);
  }

  @override
  Future<bool> setStringList(String key, List<String> value) async {
    var shared = await sharedPreferences;
    return await shared.setStringList(key, value);
  }
}
