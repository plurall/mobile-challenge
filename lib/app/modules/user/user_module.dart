import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/data/local_favorites_datasource.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/domain/usecases/verify_favorite.dart';
import 'package:mobile_challenge/app/modules/user/features/profile/infra/datasources/favorites_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/profile/data/remote_profile_datasource.dart';
import 'features/profile/domain/usecases/get_favorites.dart';
import 'features/profile/domain/usecases/remove_favorite.dart';
import 'features/profile/domain/usecases/save_favorite.dart';
import 'features/profile/domain/usecases/user_profile.dart';
import 'features/profile/infra/repositories/favorites_repository_impl.dart';
import 'features/profile/infra/repositories/profile_repository_impl.dart';
import 'features/profile/ui/favorites_page.dart';
import 'features/profile/ui/profile_page.dart';
import 'features/search/data/remote_search_user_datasource.dart';
import 'features/search/domain/usecases/search_user.dart';
import 'features/search/infra/repositories/search_user_repository_impl.dart';
import 'features/search/ui/search_page.dart';

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
    Bind((i) => LocalFavoritesDatasource(i())),
    Bind((i) => GetFavoritesImpl(i())),
    Bind((i) => VerifyFavoriteImpl(i())),
    Bind((i) => SaveFavoriteImpl(i())),
    Bind((i) => RemoveFavoriteImpl(i())),
    Bind((i) => FavoritesRepositoryImpl(i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, args) => SearchPage()),
    ChildRoute('/profile/:username', child: (_, args) => ProfilePage(args.params["username"])),
    ChildRoute('/profile/favorites', child: (_, args) => FavoritesPage()),
  ];

}