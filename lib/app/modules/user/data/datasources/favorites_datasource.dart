import '../../domain/entities/user_detail_entity.dart';
import '../models/user_detail_model.dart';

abstract class FavoritesDataSource {
  Future<List<UserDetailModel>> getFavorites();
  Future<bool> verifyFavorite(UserDetailEntity user);
  Future<bool> saveFavorite(UserDetailEntity user);
  Future<bool> removeFavorite(UserDetailEntity user);
}