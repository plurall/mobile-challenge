import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_challenge/app/core/errors/errors.dart';
import 'package:mobile_challenge/app/core/usecase/usecase.dart';
import 'package:mobile_challenge/app/features/domain/entities/user.dart';
import 'package:mobile_challenge/app/features/domain/repositories/users_repository.dart';

@lazySingleton
class SaveFavoriteUser implements Usecase<bool, SaveUserParams> {
  final UsersRepository usersRepository;

  SaveFavoriteUser(this.usersRepository);

  Future<Either<Failure, bool>> call(SaveUserParams params) async {
    return await usersRepository.saveFavoriteUser(params.user);
  }
}

class SaveUserParams extends Equatable {
  final User user;

  SaveUserParams({required this.user});

  @override
  List<Object?> get props => <Object>[user];
}
