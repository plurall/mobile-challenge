import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/core/error/failures.dart';
import 'package:mobile_challenge/features/search_user/domain/entities/user_detail_entity.dart';
import 'package:mobile_challenge/features/search_user/domain/repositories/favorite_local_repository.dart';

class SaveFavoriteLocal {
  final IFavoriteLocalRepository repository;

  SaveFavoriteLocal(this.repository);

  Future<Either<Failure, void>> call(UserDetailEntity userDetailEntity) async {
    return repository.saveFavoriteLocalUser(userDetailEntity);
  }
}
