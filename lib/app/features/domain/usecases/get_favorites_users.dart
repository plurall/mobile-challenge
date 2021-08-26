import 'package:injectable/injectable.dart';
import 'package:mobile_challenge/app/core/errors/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/app/core/usecase/usecase.dart';
import 'package:mobile_challenge/app/features/domain/entities/user.dart';
import 'package:mobile_challenge/app/features/domain/repositories/users_repository.dart';

@lazySingleton
class GetFavoritesUsers implements Usecase<List<User>, NoParams> {
  final UsersRepository usersRepository;

  GetFavoritesUsers(this.usersRepository);
  @override
  Future<Either<Failure, List<User>>> call(NoParams noParams) async {
    return await usersRepository.getFavoritesUsers();
  }
}
