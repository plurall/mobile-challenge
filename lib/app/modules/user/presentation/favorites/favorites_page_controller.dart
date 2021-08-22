import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_favorites.dart';

part 'favorites_page_controller.g.dart';

class FavoritesPageController = _FavoritesPageControllerBase with _$FavoritesPageController;
enum FavoritesPageState {IDLE, LOADING}

abstract class _FavoritesPageControllerBase with Store {

  final GetFavoritesImpl getFavoritesUsecase = Modular.get();
  ObservableList<UserEntity> favorites = ObservableList();

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