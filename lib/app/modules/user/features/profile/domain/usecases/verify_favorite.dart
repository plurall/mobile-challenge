import 'package:mobile_challenge/app/modules/user/features/profile/domain/entities/user_detail_entity.dart';

import '../../../profile/domain/repositories/favorites_repository.dart';

abstract class VerifyFavorite {
  Future<bool> call(UserDetailEntity user);
}

class VerifyFavoriteImpl implements VerifyFavorite {
  final FavoritesRepository repository;

  VerifyFavoriteImpl(this.repository);
  @override
  Future<bool> call(UserDetailEntity user) async {
    return await repository.verifyFavorite(user);
  }
}