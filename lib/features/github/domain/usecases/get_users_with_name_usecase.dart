import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_challenge/core/domain/usecases/usecase.dart';
import 'package:mobile_challenge/core/errors/failures.dart';
import 'package:mobile_challenge/features/github/domain/entities/users_entity.dart';
import 'package:mobile_challenge/features/github/domain/repositories/github_repositoy.dart';

class GetUsersWithNameUseCase extends UseCase<UsersEntity, String> {
  final GithubRepository repository;

  GetUsersWithNameUseCase(this.repository);

  @override
  Future<Either<Failure, UsersEntity>> call(String name) async {
    return await repository.getUsersWithName(name);
  }  
}
