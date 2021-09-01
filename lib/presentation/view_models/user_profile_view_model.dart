import 'package:mobile_challenge/data/models/user.dart';
import 'package:mobile_challenge/domain/usecases/get_user/get_user_interface.dart';

class UserProfileViewModel {
  final GetUserUseCaseInterface useCase;
  UserProfileViewModel(this.useCase);

  Future<User> getUser(String login) async {
    final response = await useCase.call(login);
    if (response.isRight()) {
      return response.getOrElse(() => User(
          login: '',
          bio: '',
          name: '',
          avatar: '',
          id: 0,
          location: '',
          email: ''));
    } else {
      throw Exception('User não encontrado');
    }
  }
}
