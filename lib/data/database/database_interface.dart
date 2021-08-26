abstract class DatabaseInterface {
  database();
  Future<void> insert(String table, Map<String, Object> data);
  Future<void> delete(String table, int id);
  Future<List<Map<String, dynamic>>> getData(String table);
}
