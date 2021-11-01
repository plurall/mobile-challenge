import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/core/erros/failures.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/entity/user_entity.dart';
import 'package:mobile_challenge/app/modules/users_search/data/datasource/user_search_datasource.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/repository/user_search_respository.dart';

class UserSearchRepository implements IUserSearchRepository {
  final IUserSearchDataSource _datasource;

  UserSearchRepository(this._datasource);

  @override
  Future<Either<Failure, List<UserEntity>>> userSearch(
    String searchTerm,
  ) async {
    try {
      final response = await _datasource.userSearch(searchTerm);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: 'ServerFailure'));
    }
  }
}
