import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/modules/user/features/search/ui/search_page.dart';

import 'features/favorites/domain/ui/pages/favorites_page.dart';
import 'features/favorites/domain/usecases/get_favorites.dart';
import 'features/favorites/domain/usecases/remove_favorite.dart';
import 'features/favorites/domain/usecases/save_favorite.dart';
import 'features/favorites/infra/repositories/favorites_repository_impl.dart';
import 'features/profile/data/remote_profile_datasource.dart';
import 'features/profile/domain/usecases/user_profile.dart';
import 'features/profile/infra/repositories/profile_repository_impl.dart';
import 'features/profile/ui/profile_page.dart';
import 'features/search/data/remote_search_user_datasource.dart';
import 'features/search/domain/usecases/search_user.dart';
import 'features/search/infra/repositories/search_user_repository_impl.dart';

class UserModule extends Module {
  @override
  List<Bind> get binds => [
    //search
    Bind((i) => RemoteSearchUserDataSource(i())),
    Bind((i) => SearchUserRepositoryImpl(i())),
    Bind((i) => SearchUserImpl(i())),
    //profile
    Bind((i) => RemoteProfileDatasource(i())),
    Bind((i) => ProfileRepositoryImpl(i())),
    Bind((i) => UserProfileImpl(i())),
    //favorites
    Bind((i) => GetFavoritesImpl(i())),
    Bind((i) => SaveFavoriteImpl(i())),
    Bind((i) => RemoveFavoriteImpl(i())),
    Bind((i) => FavoritesRepositoryImpl(i())),
    Bind((i) => RemoveFavoriteImpl(i())),
    Bind((i) => SaveFavoriteImpl(i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, args) => SearchPage()),
    ChildRoute('/profile/:username', child: (_, args) => ProfilePage(args.params["username"])),
    ChildRoute('/favorites', child: (_, args) => FavoritesPage()),
  ];

}