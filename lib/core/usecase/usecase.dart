import 'package:dartz/dartz.dart';

import 'errors/error.dart';

abstract class Usecase<Output, Input> {
  Future<Either<Failure, Output>> call(Input params);
}
