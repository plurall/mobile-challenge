import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/core/domain/usecases/usecase.dart';
import 'package:mobile_challenge/core/errors/failures.dart';
import 'package:mobile_challenge/features/github/domain/entities/user_entity.dart';
import 'package:mobile_challenge/features/github/domain/repositories/github_repository.dart';

class SaveUserUseCase implements UseCase<bool, UserEntity> {
  final GithubRepository repository;

  SaveUserUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(UserEntity user) async {
    return await repository.saveUser(user);
  }
}
