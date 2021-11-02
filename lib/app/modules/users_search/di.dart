import 'package:get_it/get_it.dart';
import 'package:mobile_challenge/app/core/httpClient/http_client_imp.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/usecase/user_detail_usecase.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/usecase/user_search_usecase.dart';
import 'package:mobile_challenge/app/modules/users_search/ui/controller/user_detail_controller.dart';
import 'package:mobile_challenge/app/modules/users_search/ui/controller/user_search_controller.dart';
import 'package:mobile_challenge/app/modules/users_search/data/datasource/user_detail_datasource.dart';
import 'package:mobile_challenge/app/modules/users_search/data/datasource/user_search_datasource.dart';
import 'package:mobile_challenge/app/modules/users_search/data/repository/user_detail_repository_imp.dart';
import 'package:mobile_challenge/app/modules/users_search/data/repository/user_search_repository_imp.dart';

class UserSearchInjection {
  void call(GetIt instanceGetIt) {
    instanceGetIt
      ..registerSingleton<HttpClient>(HttpClient())
      ..registerLazySingleton<UserSearchDataSource>(
        () => UserSearchDataSource(
          instanceGetIt<HttpClient>(),
        ),
      )
      ..registerLazySingleton<UserSearchRepository>(
        () => UserSearchRepository(
          instanceGetIt<UserSearchDataSource>(),
        ),
      )
      ..registerLazySingleton<UserSearchUsecase>(
        () => UserSearchUsecase(
          instanceGetIt<UserSearchRepository>(),
        ),
      )
      ..registerSingleton<UserSearchController>(
        UserSearchController(
          usecase: instanceGetIt<UserSearchUsecase>(),
        ),
      )
      ..registerLazySingleton<UserDetailDataSource>(
        () => UserDetailDataSource(
          instanceGetIt<HttpClient>(),
        ),
      )
      ..registerLazySingleton<UserDetailRepository>(
        () => UserDetailRepository(
          instanceGetIt<UserDetailDataSource>(),
        ),
      )
      ..registerLazySingleton<UserDetailUsecase>(
        () => UserDetailUsecase(
          instanceGetIt<UserDetailRepository>(),
        ),
      )
      ..registerSingleton<UserDetailController>(
        UserDetailController(
          usecase: instanceGetIt<UserDetailUsecase>(),
        ),
      );
  }
}
