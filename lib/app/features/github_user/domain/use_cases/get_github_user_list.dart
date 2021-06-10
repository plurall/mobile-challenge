import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/github_user.dart';
import '../repositories/github_search_repository.dart';

class GithubUserList implements UseCase<List<GithubUser>, Params> {
  final GithubUserRepository repository;
  GithubUserList(this.repository);

  @override
  Future<Either<Failure, List<GithubUser>>> call(Params params) async {
    return await repository.getGithubUsers(params.userName);
  }
}

class Params extends Equatable {
  final String userName;

  Params({@required this.userName});

  @override
  List<Object> get props => [userName];
}
