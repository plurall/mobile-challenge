import 'package:mobile_challenge/app/models/user_model.dart';

abstract class IFavoritesDatabase {
  Future create(UserModel model);
  Future delete(int id);
}
