import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/modules/users/domain/repositories/get_users.repositoory.dart';

import 'get_users.usecase.dart';

class GetUsersUsecaseImpl implements GetUsersUsecase {
  final GetUsersRepository _repository;
  GetUsersUsecaseImpl(this._repository);

  @override
  Future<Either<Exception, List<UserEntity>>> call(String text) {
    return _repository(text);
  }
}
