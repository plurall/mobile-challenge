import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/core/errors/errors.dart';
import 'package:mobile_challenge/app/modules/user_search/domain/entities/user.dart';
import 'package:mobile_challenge/app/modules/user_search/domain/repositories/user_repository.dart';
import 'package:mobile_challenge/app/modules/user_search/infra/datasources/user_search_datasource.dart';

class UserSearchRepositoryImpl implements UserSearchRepository {

  final UserSearchDatasource datasource;

  UserSearchRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureSearch, UserSearch>> search(String searchText) async {
    try{
      final result = await datasource.getSearch(searchText);
      return Right(result);
    } on DataSourceError catch  (e){
      return Left(e);
    } catch (e){
      return Left(DataSourceError());
    }
  }

}