import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';

abstract class GetFavoritesDatasource {
  Future<List<UserModel>> call();
}
