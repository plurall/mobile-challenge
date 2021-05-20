import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/core/domain/usecases/usecase.dart';
import 'package:mobile_challenge/core/errors/failures.dart';
import 'package:mobile_challenge/features/github/domain/entities/users_entity.dart';
import 'package:mobile_challenge/features/github/domain/repositories/github_repository.dart';

class GetBookmarkUsersUseCase implements UseCase<UsersEntity, NoParams> {
  final GithubRepository repository;

  GetBookmarkUsersUseCase(this.repository);

  @override
  Future<Either<Failure, UsersEntity>> call(NoParams params) async {
    return await repository.getBookmarkedUsers();
  }
}
