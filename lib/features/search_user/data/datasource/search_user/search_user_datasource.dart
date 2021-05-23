import 'package:mobile_challenge/features/search_user/data/models/user_model.dart';

abstract class ISerchUserDatasource {
  Future<List<UserModel>> searchUserByText(String text);
}
