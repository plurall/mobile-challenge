import 'package:mobile_challenge/app/modules/users/data/datasource/do_favorite_user.datasource.dart';
import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';
import 'package:mobile_challenge/app/shared/helper/db_helper.dart';

class DoFavoriteUserDatasourceImpl implements DoFavoriteUserDatasource {
  final DatabaseHelp _db;
  DoFavoriteUserDatasourceImpl(this._db);

  @override
  Future<void> call(UserModel model) async {
    try {
      await _db.insertItem(model);
      return;
    } catch (error) {
      return throw Exception();
    }
  }
}
