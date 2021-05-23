import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/core/error/failures.dart';
import 'package:mobile_challenge/features/search_user/data/datasource/detail_user/show_detail_user_datasource.dart';
import 'package:mobile_challenge/features/search_user/domain/entities/user_detail_entity.dart';
import 'package:mobile_challenge/features/search_user/domain/repositories/get_detail_user_repository.dart';

class ShowDetailUserRepositoryImpl implements IShowDetailUserRepository {
  final IShowDetailUserDataSource datasource;

  ShowDetailUserRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, UserDetailEntity>> showDetailUser(String text) async {
    try {
      return right(await datasource.showDetailUser(text));
    } catch (e) {
      return left(ServerFailure());
    }
  }
}
