import 'package:mobile_challenge/clean/usecase.dart';
import 'package:mobile_challenge/modules/favorites/data/repositories/favorites_repository.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

class GetFavoriteList implements UseCase<List<User>, NoParams> {
  GetFavoriteList(this.repo);

  final FavoritesRepositoryProtocol repo;

  @override
  Future<List<User>> call(NoParams params) async {
    return await repo.getFavoritesList();
  }
}
