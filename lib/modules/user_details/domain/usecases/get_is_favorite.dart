import 'package:mobile_challenge/clean/usecase.dart';
import 'package:mobile_challenge/modules/user_details/data/repositories/favorite_user_repository.dart';

class GetIsFavorite implements UseCase<bool, GetIsFavoriteParams> {
  GetIsFavorite(this.favoritesRepo);

  final FavoriteUserRepositoryProtocol favoritesRepo;

  @override
  Future<bool> call(GetIsFavoriteParams params) async {
    return await favoritesRepo.isFavorite(params.nickname);
  }
}

class GetIsFavoriteParams {
  GetIsFavoriteParams(this.nickname);

  final String nickname;
}
