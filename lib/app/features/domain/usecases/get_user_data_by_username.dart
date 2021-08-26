import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_challenge/app/core/errors/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/core/usecase/usecase.dart';
import 'package:mobile_challenge/app/features/domain/entities/user.dart';
import 'package:mobile_challenge/app/features/domain/repositories/users_repository.dart';

@lazySingleton
class GetUserDataByUsername implements Usecase<User, UserParams> {
  final UsersRepository repository;

  GetUserDataByUsername(this.repository);

  @override
  Future<Either<Failure, User>> call(UserParams userParams) async {
    if (userParams.username.isEmpty) {
      return Left(InvalidUsernameFailure(message: 'Username inválido.'));
    }
    return await repository.getUser(userParams.username);
  }
}

class UserParams extends Equatable {
  final String username;

  UserParams({required this.username});

  @override
  List<Object?> get props => <Object>[username];
}
