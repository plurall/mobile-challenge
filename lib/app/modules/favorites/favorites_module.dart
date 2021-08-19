import 'package:flutter_modular/flutter_modular.dart';

import 'domain/ui/pages/favorites_page.dart';
import 'domain/usecases/get_favorites.dart';
import 'domain/usecases/remove_favorite.dart';
import 'domain/usecases/save_favorite.dart';
import 'infra/repositories/favorites_repository_impl.dart';

class FavoritesModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((i) => GetFavoritesImpl(i())),
    Bind((i) => FavoritesRepositoryImpl(i())),
    Bind((i) => RemoveFavoriteImpl(i())),
    Bind((i) => SaveFavoriteImpl(i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, args) => FavoritesPage()),
  ];

}