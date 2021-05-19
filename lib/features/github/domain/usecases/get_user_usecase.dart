import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/core/domain/usecases/usecase.dart';
import 'package:mobile_challenge/core/errors/failures.dart';
import 'package:mobile_challenge/features/github/domain/entities/user_entity.dart';
import 'package:mobile_challenge/features/github/domain/repositories/github_repositoy.dart';

class GetUserUseCase extends UseCase<UserEntity, String> {
  final GithubRepository repository;

  GetUserUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(String username) async {
    return await repository.getUser(username);
  }
}
