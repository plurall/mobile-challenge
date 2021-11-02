import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/core/erros/failures.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/entity/user_entity.dart';
import 'package:mobile_challenge/app/modules/users_search/data/datasource/user_detail_datasource.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/repository/user_detail_repository.dart';

class UserDetailRepository implements IUserDetailRepository {
  final IUserDetailDataSource _dataSource;

  UserDetailRepository(this._dataSource);

  @override
  Future<Either<Failure, UserEntity>> userDetail(detailUrl) async {
    try {
      final response = await _dataSource.userDetail(detailUrl);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: 'ServerFailure'));
    }
  }
}
