import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/core/usecase/errors/exceptions.dart';
import 'package:mobile_challenge/core/usecase/errors/failures.dart';
import 'package:mobile_challenge/features/search_user/data/datasource/search_user_datasource.dart';
import 'package:mobile_challenge/features/search_user/domain/entities/user_entity.dart';
import 'package:mobile_challenge/features/search_user/domain/repositories/search_user_repository.dart';

class SearchRepositoryImpl implements ISearchUserRepository {
  final ISerchUserDatasource datasource;

  SearchRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers(String text) async {
    try {
      final result = await datasource.searchUserByText(text);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
