import 'package:mobile_challenge/core/errors/remote_exception.dart';
import 'package:mobile_challenge/data/models/user.dart';
import 'package:dartz/dartz.dart';

abstract class SearchRemoteInterface {
  Future<Either<RemoteException, List<User>>> searchUsers(String search);
  Future<Either<RemoteException, User>> getUser(String login);
}
