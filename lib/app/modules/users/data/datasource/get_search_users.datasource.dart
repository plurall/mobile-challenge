import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';

abstract class GetSearchUsersDatasource {
  Future<List<UserModel>> call(String text, int page);
}
