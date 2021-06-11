import 'package:mobile_challenge/app/modules/favorites/domain/usecases/get_favorites.usecase.dart';
import 'package:mobile_challenge/app/modules/users/domain/entities/user.entity.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
part 'favorites_controller.g.dart';

@Injectable()
class FavoritesController = _FavoritesControllerBase with _$FavoritesController;

abstract class _FavoritesControllerBase with Store {
  final GetFavoritesUsecase _usecase;
  _FavoritesControllerBase(this._usecase);

  @observable
  bool isLoading = false;

  @action
  changeLoading(value) => isLoading = value;

  @observable
  bool isError = false;

  @action
  changeError(value) => isError = value;

  @observable
  List<UserEntity> users = [];

  @action
  changeUsers(List<UserEntity> value) => users = value;

  getFavorites() async {
    changeError(false);
    changeLoading(true);

    var result = await _usecase();
    changeLoading(false);

    result.fold((error) {
      changeError(true);
    }, (response) {
      changeUsers(response);
    });
  }
}
