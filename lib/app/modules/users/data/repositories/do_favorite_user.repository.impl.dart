import 'package:mobile_challenge/app/modules/users/data/datasource/do_favorite_user.datasource.dart';
import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';
import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/modules/users/domain/repositories/do_favorite_user.repository.dart';

class DoFavoriteUserRepositoryImpl implements DoFavoriteUserRepository {
  final DoFavoriteUserDatasource _datasource;
  DoFavoriteUserRepositoryImpl(this._datasource);
  @override
  Future<Either<Exception, void>> call(UserEntity entity) async {
    try {
      await _datasource(UserModel.fromEntity(entity));
      return Right(Unit);
    } catch (error) {
      return Left(error);
    }
  }
}
