import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/core/network/network_info.dart';

import 'features/profile/data/local_favorites_datasource.dart';
import 'features/profile/data/local_profile_datasource.dart';
import 'features/profile/data/remote_profile_datasource.dart';
import 'features/profile/domain/usecases/get_favorites.dart';
import 'features/profile/domain/usecases/remove_favorite.dart';
import 'features/profile/domain/usecases/save_favorite.dart';
import 'features/profile/domain/usecases/user_profile.dart';
import 'features/profile/domain/usecases/verify_favorite.dart';
import 'features/profile/infra/repositories/favorites_repository_impl.dart';
import 'features/profile/infra/repositories/profile_repository_impl.dart';
import 'features/profile/presenter/favorites/favorites_page.dart';
import 'features/profile/presenter/profile_page/profile_page.dart';
import 'features/search/data/remote_search_user_datasource.dart';
import 'features/search/domain/usecases/search_user.dart';
import 'features/search/infra/repositories/search_user_repository_impl.dart';
import 'features/search/ui/search_page.dart';

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