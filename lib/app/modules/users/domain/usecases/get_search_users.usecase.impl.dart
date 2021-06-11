import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/modules/users/domain/repositories/get_search_users.repository.dart';

import 'get_search_users.usecase.dart';

class GetSearchUsersUsecaseImpl implements GetSearchUsersUsecase {
  final GetSearchUsersRepository _repository;
  GetSearchUsersUsecaseImpl(this._repository);

  @override
  Future<Either<Exception, List<UserEntity>>> call(
      String search, int page) async {
    return await _repository(search, page);
  }
}
