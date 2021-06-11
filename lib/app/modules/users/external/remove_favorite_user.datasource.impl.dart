import 'package:mobile_challenge/app/core/shared/helper/db_helper.dart';
import 'package:mobile_challenge/app/modules/users/data/datasource/remove_favorite_user.datasource.dart';

class RemoveFavoriteUserDatasourceImpl implements RemoveFavoriteUserDatasource {
  final DatabaseHelp _db;
  RemoveFavoriteUserDatasourceImpl(this._db);

  @override
  Future<void> call(int id) async {
    try {
      await _db.deleteItem(id);
      return;
    } catch (error) {
      return throw Exception();
    }
  }
}
