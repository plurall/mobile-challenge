import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/modules/favorites/presentation/controllers/favorites_controller.dart';
import 'package:mobile_challenge/app/modules/favorites/presentation/pages/favorites.page.dart';
import 'package:mobile_challenge/app/shared/helper/db_helper.dart';

import 'data/repositories/get_favorites.repository.impl.dart';
import 'domain/usecases/get_favorites.usecase.impl.dart';
import 'external/get_favorites.datasource.impl.dart';

class FavoritesModule extends Module {
  @override
  final List<Bind> binds = [
    $FavoritesController,
    Bind((i) => DatabaseHelp()),
    Bind((i) => GetFavoritesUsecaseImpl(GetFavoritesRepositoryImpl(i.get()))),
    Bind((i) => GetFavoritesDatasourceImpl(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => FavoritesPage()),
  ];
}
