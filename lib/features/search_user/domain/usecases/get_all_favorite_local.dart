import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/core/error/failures.dart';
import 'package:mobile_challenge/features/search_user/domain/entities/user_detail_entity.dart';
import 'package:mobile_challenge/features/search_user/domain/repositories/get_all_favorite_local_repository.dart';

class GetAllFavoriteLocal {
  final IGetAllFavoriteLocalRepository repository;

  GetAllFavoriteLocal(this.repository);

  Future<Either<Failure, List<UserDetailEntity>>> call() async {
    return repository.showFavoriteLocalUsers();
  }
}
