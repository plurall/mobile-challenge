import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/modules/user/data/datasources/favorites_datasource.dart';
import 'package:mobile_challenge/app/modules/user/data/datasources/local_profile_datasource.dart';
import 'package:mobile_challenge/app/modules/user/data/datasources/profile_datasource.dart';
import 'package:mobile_challenge/app/modules/user/domain/repositories/favorites_repository.dart';
import 'package:mobile_challenge/app/modules/user/domain/repositories/profile_repository.dart';
import 'package:mobile_challenge/app/modules/user/domain/repositories/search_user_repository.dart';

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
    Bind<RemoteSearchUserDataSource>((i) => RemoteSearchUserDataSource(i())),
    Bind<SearchUserRepository>((i) => SearchUserRepositoryImpl(datasource: i(), networkInfo: i())),
    Bind<SearchUser>((i) => SearchUserImpl(i())),
    //profile
    Bind<RemoteProfileDatasource>((i) => RemoteProfileDatasourceImpl(i())),
    Bind<LocalProfileDatasource>((i) => LocalProfileDatasourceImpl(i())),
    Bind<ProfileRepository>((i) => ProfileRepositoryImpl(remoteDatasource: i(),localDatasource: i(), networkInfo: i())),
    Bind<UserProfile>((i) => UserProfileImpl(i())),
    //favorites
    Bind<FavoritesDataSource>((i) => LocalFavoritesDatasource(i())),
    Bind<GetFavorites>((i) => GetFavoritesImpl(i())),
    Bind<VerifyFavorite>((i) => VerifyFavoriteImpl(i())),
    Bind<SaveFavorite>((i) => SaveFavoriteImpl(i())),
    Bind<RemoveFavorite>((i) => RemoveFavoriteImpl(i())),
    Bind<FavoritesRepository>((i) => FavoritesRepositoryImpl(i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, args) => SearchPage()),
    ChildRoute('/profile/:username', child: (_, args) => ProfilePage(args.params["username"])),
    ChildRoute('/profile/favorites', child: (_, args) => FavoritesPage()),
  ];

}