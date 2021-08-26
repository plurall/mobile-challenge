import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/errors/errors.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/users_repository.dart';
import '../../infra/drivers/users_driver.dart';
import '../datasources/users_datasource.dart';

@LazySingleton(as: UsersRepository)
class UsersRepositoryImpl implements UsersRepository {
  final UsersDatasource usersDatasource;
  final UsersDriver usersDriver;

  UsersRepositoryImpl(this.usersDatasource, this.usersDriver);
  @override
  Future<Either<Failure, User>> getUser(String username) async {
    try {
      final result = await usersDatasource.getUser(username);
      return Right(result);
    } catch (error) {
      return Left(
        DatasourceError(
          message: 'Ocorreu um erro ao buscar os dados do usuário.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<User>>> getFavoritesUsers() async {
    try {
      final result = await usersDriver.getFavoritesUsers();
      return Right(result);
    } catch (error) {
      return Left(
        CacheError(message: 'Ocorreu um erro ao buscar os usuários favoritos.'),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> saveFavoriteUser(User user) async {
    try {
      final result = await usersDriver.saveFavoritesUser(user);
      return Right(result);
    } catch (error) {
      return Left(
        CacheError(
          message: 'Ocorreu um erro ao salvar o usuário como favorito.',
        ),
      );
    }
  }
}
