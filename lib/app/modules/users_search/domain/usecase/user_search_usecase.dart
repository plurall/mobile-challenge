import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/core/erros/failures.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/entity/user_entity.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/repository/user_search_respository.dart';

abstract class IUserSearchUsecase {
  Future<Either<Failure, List<UserEntity>>> userSearch(String searchTerm);
}

class UserSearchUsecase implements IUserSearchUsecase {
  final IUserSearchRepository _repository;

  UserSearchUsecase(this._repository);

  @override
  Future<Either<Failure, List<UserEntity>>> userSearch(
    String searchTerm,
  ) async =>
      await _repository.userSearch(searchTerm);
}
