import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/features/search_user/data/datasource/search_user_datasource.dart';
import 'package:mobile_challenge/features/search_user/domain/errors/erros.dart';
import 'package:mobile_challenge/features/search_user/domain/entities/user.dart';
import 'package:mobile_challenge/features/search_user/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDatasource datasource;

  SearchRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<User>>> getUsers(String searchText) {
    throw UnimplementedError();
  }
}
