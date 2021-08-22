import '../models/user_detail_model.dart';

abstract class RemoteProfileDatasource {
  Future<UserDetailModel> getUser(String username);
}