import 'package:dartz/dartz.dart';

import 'package:mobile_challenge/data/models/user.dart';
import 'package:mobile_challenge/domain/repositories/search_remote_interface.dart';
import 'package:mobile_challenge/domain/usecases/search_users/search_users_interface.dart';

class SearchUsersUseCase implements SearchUsersUseCaseInterface {
  final SearchRemoteInterface repository;
  SearchUsersUseCase(
    this.repository,
  );

  @override
  Future<Either<Exception, List<User>>> call(String search) {
    return repository.searchUsers(search);
  }
}
