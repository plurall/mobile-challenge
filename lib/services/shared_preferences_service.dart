import 'package:mobile_challenge/interfaces/local_storage_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService implements ILocalStorage {
  @override
  Future<String> get(String key) async {
    final _storage = await SharedPreferences.getInstance();
    final result = _storage.getString(key);
    return result;
  }

  @override
  Future<bool> put(String key, dynamic value) async {
    final _storage = await SharedPreferences.getInstance();
    return _storage.setString(key, value);
  }

  @override
  Future<bool> delete(String key) async {
    final _storage = await SharedPreferences.getInstance();
    return _storage.remove(key);
  }

  void clear() async {
    final _storage = await SharedPreferences.getInstance();
    await _storage.clear();
  }
}
