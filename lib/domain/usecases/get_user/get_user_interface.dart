import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/data/models/user.dart';

abstract class GetUserUseCaseInterface {
  Future<Either<Exception, User>> call(String login);
}
