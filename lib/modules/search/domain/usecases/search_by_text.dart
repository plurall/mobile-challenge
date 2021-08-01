import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/modules/search/domain/entities/result_search.dart';
import 'package:mobile_challenge/modules/search/domain/errors/errors.dart';
import 'package:mobile_challenge/modules/search/domain/repositories/search_repository.dart';

abstract class SearchByText{
  Future<Either<FailureSearch,List<ResultSearch>>> call(String searchText);
}

class SearchByTextImpl implements SearchByText{

  final SearchRepository repository;
  SearchByTextImpl(this.repository);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> call(String searchText) async {
      if(searchText==null || searchText.isEmpty){
        return left(InvalidTextError());
      }

      return repository.search(searchText);
  }

}