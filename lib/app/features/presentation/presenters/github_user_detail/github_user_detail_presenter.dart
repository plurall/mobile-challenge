import 'package:mobile_challenge/app/features/domain/entities/user.dart';

abstract class GithubUserDetailPresenter {
  abstract bool isLoading;
  abstract String? error;
  abstract User? user;
  Future<void> getUserData(String username);
}
