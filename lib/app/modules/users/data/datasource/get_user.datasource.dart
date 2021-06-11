import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';

abstract class GetUserDatasource {
  Future<UserModel> call(int page);
}
