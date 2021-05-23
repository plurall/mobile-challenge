import 'package:mobile_challenge/features/search_user/data/models/detail_user_model.dart';
import 'package:mobile_challenge/features/search_user/domain/entities/user_detail_entity.dart';

abstract class IShowDetailUserDataSource {
  Future<DetailUserModel> showDetailUser(String text);
}
