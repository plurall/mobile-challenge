import 'package:mobile_challenge/app/core/shared/helper/db_helper.dart';
import 'package:mobile_challenge/app/modules/favorites/data/datasources/get_favorites.datasource.dart';
import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';

class GetFavoritesDatasourceImpl implements GetFavoritesDatasource {
  final DatabaseHelp _db;
  GetFavoritesDatasourceImpl(this._db);

  @override
  Future<List<UserModel>> call() async {
    try {
      return await _db.getItems();
    } catch (error) {
      return throw Exception();
    }
  }
}
