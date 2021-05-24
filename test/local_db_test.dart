import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/shared/datasources/favorites_local_data_source.dart';

void main() {
  test('test direct file write', () async {
    FavoritesLocalDataSource dataSource = FavoritesLocalDataSource();

    await dataSource.writeDb("test.json", {"test": "test passed"});
    var saved = await FavoritesLocalDataSource().readDb("test.json");
    expect(saved["test"], "test passed");
  });
}
