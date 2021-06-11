import 'package:mobile_challenge/app/modules/users/data/datasource/get_user.datasource.dart';
import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';
import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/modules/users/domain/repositories/get_user.repository.dart';

class GetUserRepositoryImpl implements GetUserRepository {
  final GetUserDatasource _datasource;
  GetUserRepositoryImpl(this._datasource);
  @override
  Future<Either<Exception, UserEntity>> call(int page) async {
    try {
      var result = await _datasource(page);
      return Right(UserModel.toEntity(result));
    } catch (error) {
      return Left(error);
    }
  }
}
