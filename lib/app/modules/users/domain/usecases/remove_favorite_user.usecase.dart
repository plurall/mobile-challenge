import 'package:dartz/dartz.dart';

abstract class RemoveFavoriteUserUsecase {
  Future<Either<Exception, void>> call(int id);
}
