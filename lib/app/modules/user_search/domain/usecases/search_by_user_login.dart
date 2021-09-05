import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/core/errors/errors.dart';
import 'package:mobile_challenge/app/modules/user_search/domain/entities/user.dart';
import 'package:mobile_challenge/app/modules/user_search/domain/repositories/user_repository.dart';

abstract class SearchByUserLogin {
  Future<Either<FailureSearch, UserSearch>> call(String searchText);
}

class SearchByUserLoginImpl implements SearchByUserLogin {
  final UserSearchRepository repository;

  SearchByUserLoginImpl(this.repository);

  @override
  Future<Either<FailureSearch, UserSearch>> call(
      String searchText) async {
    if(searchText == null){
      return Left(InvalidTextError());
    }

    return repository.search(searchText);
  }
}