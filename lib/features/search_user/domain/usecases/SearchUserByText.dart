import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/features/search_user/domain/entities/user.dart';
import 'package:mobile_challenge/features/search_user/domain/errors/erros.dart';
import 'package:mobile_challenge/features/search_user/domain/repositories/search_repository.dart';

class SearchUserByText {
  final SearchRepository repository;

  SearchUserByText(this.repository);
  Future<Either<Failure, List<User>>> call(String searchText) async {
    return repository.getUsers(searchText);
  }
}
