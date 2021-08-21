import 'package:mobile_challenge/app/modules/user/features/profile/infra/models/user_detail_model.dart';

import '../../domain/entities/user_detail_entity.dart';

abstract class FavoritesDataSource {
  Future<List<UserDetailModel>> getFavorites();
  Future<bool> verifyFavorite(UserDetailEntity user);
  Future<bool> saveFavorite(UserDetailEntity user);
  Future<bool> removeFavorite(UserDetailEntity user);
}