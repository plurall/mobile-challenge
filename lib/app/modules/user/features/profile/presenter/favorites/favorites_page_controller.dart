import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/domain/entities/user_detail_entity.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/domain/usecases/get_favorites.dart';
import 'package:mobx/mobx.dart';
part 'favorites_page_controller.g.dart';

class FavoritesPageController = _FavoritesPageControllerBase with _$FavoritesPageController;
enum FavoritesPageState {IDLE, LOADING}

abstract class _FavoritesPageControllerBase with Store {

  final GetFavoritesImpl getFavoritesUsecase = Modular.get();
  ObservableList<UserDetailEntity> favorites = ObservableList();

  @observable
  FavoritesPageState state = FavoritesPageState.LOADING;

  @action
  Future<Null> getFavorites() async {
    state = FavoritesPageState.LOADING;

    final list = await getFavoritesUsecase();

    favorites.clear();
    favorites.addAll(list);

    state = FavoritesPageState.IDLE;
  }
}