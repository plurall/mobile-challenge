import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/core/erros/failures.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/entity/user_entity.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/repository/user_detail_repository.dart';

abstract class IUserDetailUsecase {
  Future<Either<Failure, UserEntity>> userDetail(detailUrl);
}

class UserDetailUsecase implements IUserDetailUsecase {
  final IUserDetailRepository _repository;

  UserDetailUsecase(this._repository);

  @override
  Future<Either<Failure, UserEntity>> userDetail(detailUrl) async =>
      await _repository.userDetail(detailUrl);
}
