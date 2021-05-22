import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/core/usecase/errors/error.dart';
import 'package:mobile_challenge/features/search_user/domain/entities/user_entity.dart';
import 'package:mobile_challenge/features/search_user/domain/repositories/search_user_repository.dart';

class SearchUserByText {
  final ISearchUserRepository repository;

  SearchUserByText(this.repository);

  Future<Either<Failure, List<UserEntity>>> call(String searchText) async {
    return repository.getUsers(searchText);
  }
}
