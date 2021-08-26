import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_challenge/app/core/usecase/usecase.dart';

import '../../../core/errors/errors.dart';
import '../entities/result_search.dart';
import '../repositories/search_repository.dart';

@lazySingleton
class SearchByText implements Usecase<List<ResultSearch>, SearchParams> {
  final SearchRepository repository;

  SearchByText(this.repository);

  Future<Either<Failure, List<ResultSearch>>> call(
    SearchParams searchParams,
  ) async {
    if (searchParams.query.isEmpty) {
      return Left(
        InvalidTextFailure(message: 'Texto de busca inválido.'),
      );
    }
    return await repository.search(searchParams.query);
  }
}

class SearchParams extends Equatable {
  final String query;

  SearchParams({required this.query});

  @override
  List<Object?> get props => <Object>[query];
}
