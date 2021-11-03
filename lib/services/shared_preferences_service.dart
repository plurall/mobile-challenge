import 'package:mobile_challenge/interfaces/local_storage_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService implements ILocalStorage {
  @override
  Future get(String key) async {
    final _storage = await SharedPreferences.getInstance();
    return _storage.getString(key);
  }

  @override
  Future put(String key, dynamic value) async {
    final _storage = await SharedPreferences.getInstance();
    return _storage.setString(key, value);
  }

  @override
  Future delete(String key) async {
    final _storage = await SharedPreferences.getInstance();
    return _storage.remove(key);
  }

  void clear() async {
    final _storage = await SharedPreferences.getInstance();
    _storage.clear();
  }
}
