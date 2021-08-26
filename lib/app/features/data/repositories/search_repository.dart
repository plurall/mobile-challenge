import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/errors/errors.dart';
import '../../domain/entities/result_search.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_datasource.dart';

@LazySingleton(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  final SearchDatasource searchDatasource;

  SearchRepositoryImpl(this.searchDatasource);

  @override
  Future<Either<Failure, List<ResultSearch>>> search(
    String searchText,
  ) async {
    try {
      final result = await searchDatasource.fetchSearch(searchText);
      return Right(result);
    } catch (error) {
      return Left(
        DatasourceError(message: 'Ocorreu um erro ao realizar a busca.'),
      );
    }
  }
}
