import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/core/errors/errors.dart';
import 'package:mobile_challenge/app/modules/user_search/domain/entities/user.dart';

abstract class UserSearchRepository {
  Future<Either<FailureSearch, UserSearch>> search(String searchText);
}