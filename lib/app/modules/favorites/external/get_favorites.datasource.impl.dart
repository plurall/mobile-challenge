import 'package:mobile_challenge/app/modules/favorites/data/datasources/get_favorites.datasource.dart';
import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';
import 'package:mobile_challenge/app/shared/helper/db_helper.dart';

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
