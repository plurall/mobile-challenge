import 'package:mobile_challenge/app/modules/users/data/datasource/get_search_users.datasource.dart';
import 'package:mobile_challenge/app/modules/users/data/models/user.model.dart';
import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/modules/users/domain/repositories/get_search_users.repository.dart';

class GetSearchUsersRepositoryImpl implements GetSearchUsersRepository {
  final GetSearchUsersDatasource _datasource;
  GetSearchUsersRepositoryImpl(this._datasource);
  @override
  Future<Either<Exception, List<UserEntity>>> call(
      String text, int page) async {
    try {
      var result = await _datasource(text, page);
      return Right(result.map((model) => UserModel.toEntity(model)).toList());
    } catch (error) {
      return Left(error);
    }
  }
}
