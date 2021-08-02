import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/modules/search/domain/entities/result_search.dart';
import 'package:mobile_challenge/modules/search/domain/entities/result_search_perfil.dart';
import 'package:mobile_challenge/modules/search/domain/errors/errors.dart';

abstract class SearchRepository{
  Future<Either<FailureSearch,List<ResultSearch>>> search(String searchText);

  Future<Either<FailureSearch,ResultSearchPerfil>> getPerfil(String searchText);
}