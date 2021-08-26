import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/core/errors/errors.dart';

import '../entities/result_search.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<ResultSearch>>> search(String searchText);
}
