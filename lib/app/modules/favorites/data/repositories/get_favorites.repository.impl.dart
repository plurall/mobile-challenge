import 'package:mobile_challenge/app/modules/favorites/data/datasources/get_favorites.datasource.dart';
import 'package:mobile_challenge/app/modules/favorites/domain/repositories/get_favorites.repository.dart';
import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';
import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';
import 'package:dartz/dartz.dart';

class GetFavoritesRepositoryImpl implements GetFavoritesRepository {
  final GetFavoritesDatasource _datasource;
  GetFavoritesRepositoryImpl(this._datasource);
  @override
  Future<Either<Exception, List<UserEntity>>> call() async {
    try {
      var result = await _datasource();
      return Right(result.map((model) => UserModel.toEntity(model)).toList());
    } catch (error) {
      return Left(error);
    }
  }
}
