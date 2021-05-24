import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/core/error/failures.dart';
import 'package:mobile_challenge/features/search_user/data/datasource/detail_user/show_detail_user_datasource.dart';
import 'package:mobile_challenge/features/search_user/data/models/detail_user_model.dart';
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

  @override
  Future<Either<Failure, List<UserDetailEntity>>>
      showFavoriteLocalUsers() async {
    try {
      return right(await datasource.gelAllFavoriteLocal());
    } catch (e) {
      return left(LocalFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveFavoriteLocalUser(
      UserDetailEntity userDetailEntity) async {
    try {
      return right(
        await datasource.saveFavoriteLocal(
          DetailUserModel(
            image: userDetailEntity.image,
            nickname: userDetailEntity.nickname,
            bio: userDetailEntity.bio,
            email: userDetailEntity.email,
            location: userDetailEntity.location,
          ),
        ),
      );
    } catch (e) {
      return left(LocalFailure());
    }
  }
}
