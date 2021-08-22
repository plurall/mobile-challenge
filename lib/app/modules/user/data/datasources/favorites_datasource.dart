import '../../domain/entities/user_entity.dart';
import '../models/user_detail_model.dart';

abstract class FavoritesDataSource {
  Future<List<UserDetailModel>> getFavorites();
  Future<bool> verifyFavorite(UserEntity user);
  Future<bool> saveFavorite(UserEntity user);
  Future<bool> removeFavorite(UserEntity user);
}