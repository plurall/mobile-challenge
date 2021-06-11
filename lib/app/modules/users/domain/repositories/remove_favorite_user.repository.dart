import 'package:dartz/dartz.dart';

abstract class RemoveFavoriteUserRepository {
  Future<Either<Exception, void>> call(int id);
}
