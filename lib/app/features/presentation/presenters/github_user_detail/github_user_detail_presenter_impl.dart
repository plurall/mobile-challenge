import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/get_user_data_by_username.dart';
import 'github_user_detail_presenter.dart';

part 'github_user_detail_presenter_impl.g.dart';

@Injectable(as: GithubUserDetailPresenter)
class GithubUserDetailPresenterImpl = _GithubUserDetailPresenterImplBase
    with _$GithubUserDetailPresenterImpl
    implements GithubUserDetailPresenter;

abstract class _GithubUserDetailPresenterImplBase with Store {
  final GetUserDataByUsername _getUserDataByUsername;

  @observable
  bool isLoading = false;

  @observable
  String? error;

  @observable
  User? user;

  _GithubUserDetailPresenterImplBase(this._getUserDataByUsername);

  Future<void> getUserData(String username) async {
    isLoading = true;
    final result = await _getUserDataByUsername(UserParams(username: username));
    result.fold((l) {
      error = l.message;
    }, (r) => user = r);
    isLoading = false;
  }
}
