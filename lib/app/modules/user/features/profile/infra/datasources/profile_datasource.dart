import '../models/user_detail_model.dart';

abstract class ProfileDatasource {
  Future<UserDetailModel> getUser(String username);
}