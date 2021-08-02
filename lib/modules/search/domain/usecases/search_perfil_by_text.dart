import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/modules/search/domain/entities/result_search_perfil.dart';
import 'package:mobile_challenge/modules/search/domain/errors/errors.dart';
import 'package:mobile_challenge/modules/search/domain/repositories/search_repository.dart';

abstract class SearchPerfilByText{
  Future<Either<FailureSearch,ResultSearchPerfil>> call(String searchText);
}

class SearchPerfilByTextImpl implements SearchPerfilByText{

  final SearchRepository repository;
  SearchPerfilByTextImpl(this.repository);

  @override
  Future<Either<FailureSearch, ResultSearchPerfil>> call(String searchText) async {
    if (searchText == null || searchText.isEmpty) {
      return left(InvalidTextError());
    }

    return repository.getPerfil(searchText);
  }
}