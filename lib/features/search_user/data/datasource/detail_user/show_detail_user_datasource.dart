import 'package:mobile_challenge/features/search_user/data/models/detail_user_model.dart';

abstract class IShowDetailUserDataSource {
  Future<DetailUserModel> showDetailUser(String text);
  Future<void> saveFavoriteLocal(DetailUserModel detailUserModel);
  Future<List<DetailUserModel>> gelAllFavoriteLocal();
}
