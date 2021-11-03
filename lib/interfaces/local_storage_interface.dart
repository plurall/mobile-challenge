abstract class ILocalStorage {
  Future get(String key);
  Future put(String key, dynamic value);
  Future delete(String key);
}
