import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/data/models/user.dart';

import 'package:mobile_challenge/domain/repositories/search_remote_interface.dart';
import 'package:mobile_challenge/domain/usecases/get_user/get_user_interface.dart';

class GetUserUseCase implements GetUserUseCaseInterface {
  final SearchRemoteInterface repository;
  GetUserUseCase(
    this.repository,
  );

  @override
  Future<Either<Exception, User>> call(String login) {
    return this.repository.getUser(login);
  }
}
