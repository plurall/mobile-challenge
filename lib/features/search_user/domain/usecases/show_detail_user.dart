import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/core/error/failures.dart';
import 'package:mobile_challenge/features/search_user/domain/entities/user_detail_entity.dart';
import 'package:mobile_challenge/features/search_user/domain/repositories/get_detail_user_repository.dart';

class ShowDetailUser {
  final IShowDetailUserRepository repository;

  ShowDetailUser(this.repository);

  Future<Either<Failure, UserDetailEntity>> call(String user) async {
    return repository.showDetailUser(user);
  }
}
