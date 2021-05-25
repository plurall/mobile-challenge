import 'package:mobile_challenge/clean/usecase.dart';
import 'package:mobile_challenge/modules/user_details/data/repositories/favorite_user_repository.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

class SetToggleUserFavorite
    implements UseCase<User, SetToggleUserFavoriteParams> {
  SetToggleUserFavorite(this.localRepo);

  final FavoriteUserRepositoryProtocol localRepo;

  @override
  Future<User> call(SetToggleUserFavoriteParams params) async {
    return await localRepo.toggleFavorite(params.user);
  }
}

class SetToggleUserFavoriteParams {
  SetToggleUserFavoriteParams(this.user);

  final User user;
}
