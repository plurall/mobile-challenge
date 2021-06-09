import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';

abstract class GetUsersDatasource {
  Future<List<UserModel>> call(String text);
}
