import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/modules/search/domain/entities/result_search.dart';
import 'package:mobile_challenge/modules/search/domain/errors/errors.dart';
import 'package:mobile_challenge/modules/search/domain/repositories/search_repository.dart';
import 'package:mobile_challenge/modules/search/infra/datasources/search_datasouces.dart';


class SearchRepositoryImp implements SearchRepository {

  final SearchDataSource dataSource;

  SearchRepositoryImp(this.dataSource);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> search(
      String searchText) async {
    try{
      final result = await dataSource.getSearch(searchText);
      return Right(result);
    } on  DataSourceError catch(e){
      return Left(DataSourceError());
    } catch(e){
      return Left(DataSourceError());
    }

  }
  
}