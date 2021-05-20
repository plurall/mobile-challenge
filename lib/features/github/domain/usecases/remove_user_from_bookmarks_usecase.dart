import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/core/domain/usecases/usecase.dart';
import 'package:mobile_challenge/core/errors/failures.dart';
import 'package:mobile_challenge/features/github/domain/repositories/github_repository.dart';

class RemoveUserFromBookmarksUseCase implements UseCase<bool, String> {
  final GithubRepository repository;

  RemoveUserFromBookmarksUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(String username) async {
    return await repository.removeUserFromBookmark(username);
  }
}
