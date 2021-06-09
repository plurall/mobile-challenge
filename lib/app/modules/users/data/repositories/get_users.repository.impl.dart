import 'package:mobile_challenge/app/modules/users/data/datasource/get_users.datasource.dart';
import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';
import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/modules/users/domain/repositories/get_users.repositoory.dart';

class GetUsersRepositoryImpl implements GetUsersRepository {
  final GetUsersDatasource _datasource;
  GetUsersRepositoryImpl(this._datasource);
  @override
  Future<Either<Exception, List<UserEntity>>> call(String text) async {
    try {
      var result = await _datasource(text);
      return Right(result.map((model) => UserModel.toEntity(model)).toList());
    } catch (error) {
      return Left(error);
    }
  }
}
