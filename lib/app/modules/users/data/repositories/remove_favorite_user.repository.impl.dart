import 'package:mobile_challenge/app/modules/users/data/datasource/remove_favorite_user.datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/modules/users/domain/repositories/remove_favorite_user.repository.dart';

class RemoveFavoriteUserRepositoryImpl implements RemoveFavoriteUserRepository {
  final RemoveFavoriteUserDatasource _datasource;
  RemoveFavoriteUserRepositoryImpl(this._datasource);
  @override
  Future<Either<Exception, void>> call(int id) async {
    try {
      await _datasource(id);
      return Right(Unit);
    } catch (error) {
      return Left(error);
    }
  }
}
