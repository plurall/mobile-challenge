import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/data/models/user.dart';

abstract class SearchUsersUseCaseInterface {
  Future<Either<Exception, List<User>>> call(String search);
}
