abstract class ILocaStorage {
  Future delete(String key);
  Future<List<String>> getStringList(String key);
  Future<bool> setStringList(String key, List<String> value);
}
