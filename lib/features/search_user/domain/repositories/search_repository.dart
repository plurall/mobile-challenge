import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/features/search_user/domain/entities/user.dart';
import 'package:mobile_challenge/features/search_user/domain/errors/erros.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<User>>> getUsers(String searchText);
}
