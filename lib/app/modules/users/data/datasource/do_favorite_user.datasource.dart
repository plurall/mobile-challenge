import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';

abstract class DoFavoriteUserDatasource {
  Future<void> call(UserModel page);
}
