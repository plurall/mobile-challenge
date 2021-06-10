import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/github_user_details.dart';
import '../repositories/github_search_repository.dart';

class GitHubUserDetails implements UseCase<GithubUserDetails, Params> {
  final GithubUserRepository repository;
  GitHubUserDetails(this.repository);

  @override
  Future<Either<Failure, GithubUserDetails>> call(Params params) async {
    return await repository.getGithubUserDetails(params.userName);
  }
}

class Params extends Equatable {
  final String userName;

  Params({@required this.userName});

  @override
  List<Object> get props => [userName];
}
