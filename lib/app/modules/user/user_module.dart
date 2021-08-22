import 'package:flutter_modular/flutter_modular.dart';

import 'external/datasources/local_favorites_datasource.dart';
import 'external/datasources/local_profile_datasource.dart';
import 'external/datasources/remote_profile_datasource.dart';
import 'external/datasources/remote_search_user_datasource.dart';
import 'domain/usecases/get_favorites.dart';
import 'domain/usecases/remove_favorite.dart';
import 'domain/usecases/save_favorite.dart';
import 'domain/usecases/search_user.dart';
import 'domain/usecases/user_profile.dart';
import 'domain/usecases/verify_favorite.dart';
import 'data/repositories/favorites_repository_impl.dart';
import 'data/repositories/profile_repository_impl.dart';
import 'data/repositories/search_user_repository_impl.dart';
import 'presentation/favorites/favorites_page.dart';
import 'presentation/profile/profile_page.dart';
import 'presentation/search/search_page.dart';

class UserModule extends Module {
  @override
  List<Bind> get binds => [
    //search
    Bind((i) => RemoteSearchUserDataSource(i())),
    Bind((i) => SearchUserRepositoryImpl(datasource: i(), networkInfo: i())),
    Bind((i) => SearchUserImpl(i())),
    //profile
    Bind((i) => RemoteProfileDatasourceImpl(i())),
    Bind((i) => LocalProfileDatasourceImpl(i())),
    Bind((i) => ProfileRepositoryImpl(remoteDatasource: i(),localDatasource: i(), networkInfo: i())),
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