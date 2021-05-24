import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/core/error/failures.dart';
import 'package:mobile_challenge/features/search_user/domain/entities/user_entity.dart';
import 'package:mobile_challenge/features/search_user/domain/repositories/search_user_repository.dart';

class SearchUserByTextDatasource {
  final ISearchUserRepository repository;

  SearchUserByTextDatasource(this.repository);

  Future<Either<Failure, List<UserEntity>>> call(String searchText) async {
    return repository.getUsers(searchText);
  }
}
