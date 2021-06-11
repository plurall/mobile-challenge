import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/modules/users/domain/repositories/get_user.repository.dart';

import 'get_user.usecase.dart';

class GetUserUsecaseImpl implements GetUserUsecase {
  final GetUserRepository _repository;
  GetUserUsecaseImpl(this._repository);

  @override
  Future<Either<Exception, UserEntity>> call(int page) {
    return _repository(page);
  }
}
