// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/data/datasources/search_datasource.dart' as _i7;
import '../../features/data/datasources/search_remote_datasource.dart' as _i25;
import '../../features/data/datasources/users_datasource.dart' as _i12;
import '../../features/data/datasources/users_remote_datasource.dart' as _i26;
import '../../features/data/drivers/users_driver.dart' as _i9;
import '../../features/data/repositories/search_repository.dart' as _i6;
import '../../features/data/repositories/users_repository.dart' as _i11;
import '../../features/domain/repositories/search_repository.dart' as _i5;
import '../../features/domain/repositories/users_repository.dart' as _i10;
import '../../features/domain/usecases/get_favorites_users.dart' as _i13;
import '../../features/domain/usecases/get_user_data_by_username.dart' as _i14;
import '../../features/domain/usecases/save_favorite_user.dart' as _i17;
import '../../features/domain/usecases/search_by_text.dart' as _i18;
import '../../features/infra/cache/local_storage/local_security_storage.dart'
    as _i4;
import '../../features/infra/cache/local_storage/local_storage.dart' as _i3;
import '../../features/infra/drivers/users_driver.dart' as _i8;
import '../../features/infra/http/dio/dio_rest_client.dart' as _i24;
import '../../features/infra/http/rest_client/rest_client.dart' as _i23;
import '../../features/presentation/presenters/github_favorites/github_favorites_presenter.dart'
    as _i19;
import '../../features/presentation/presenters/github_favorites/github_favorites_presenter_impl.dart'
    as _i20;
import '../../features/presentation/presenters/github_search/github_search_presenter.dart'
    as _i21;
import '../../features/presentation/presenters/github_search/github_search_presenter_impl.dart'
    as _i22;
import '../../features/presentation/presenters/github_user_detail/github_user_detail_presenter.dart'
    as _i15;
import '../../features/presentation/presenters/github_user_detail/github_user_detail_presenter_impl.dart'
    as _i16; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.LocalStorage>(() => _i4.LocalSecurityStorage());
  gh.lazySingleton<_i5.SearchRepository>(
      () => _i6.SearchRepositoryImpl(get<_i7.SearchDatasource>()));
  gh.lazySingleton<_i8.UsersDriver>(
      () => _i9.UsersDriverImpl(get<_i3.LocalStorage>()));
  gh.lazySingleton<_i10.UsersRepository>(() => _i11.UsersRepositoryImpl(
      get<_i12.UsersDatasource>(), get<_i8.UsersDriver>()));
  gh.lazySingleton<_i13.GetFavoritesUsers>(
      () => _i13.GetFavoritesUsers(get<_i10.UsersRepository>()));
  gh.lazySingleton<_i14.GetUserDataByUsername>(
      () => _i14.GetUserDataByUsername(get<_i10.UsersRepository>()));
  gh.factory<_i15.GithubUserDetailPresenter>(() =>
      _i16.GithubUserDetailPresenterImpl(get<_i14.GetUserDataByUsername>()));
  gh.lazySingleton<_i17.SaveFavoriteUser>(
      () => _i17.SaveFavoriteUser(get<_i10.UsersRepository>()));
  gh.lazySingleton<_i18.SearchByText>(
      () => _i18.SearchByText(get<_i5.SearchRepository>()));
  gh.factory<_i19.GithubFavoritesPresenter>(() =>
      _i20.GithubFavoritesPresenterImpl(
          get<_i17.SaveFavoriteUser>(), get<_i13.GetFavoritesUsers>()));
  gh.factory<_i21.GithubSearchPresenter>(
      () => _i22.GithubSearchPresenterImpl(get<_i18.SearchByText>()));
  gh.singleton<_i23.RestClient>(_i24.DioRestClient());
  gh.singleton<_i7.SearchDatasource>(
      _i25.SearchRemoteDatasource(restClient: get<_i23.RestClient>()));
  gh.singleton<_i12.UsersDatasource>(
      _i26.UsersRemoteDatasource(restClient: get<_i23.RestClient>()));
  return get;
}
