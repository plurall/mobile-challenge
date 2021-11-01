import 'package:get_it/get_it.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/usecase/user_search_usecase.dart';
import 'package:mobile_challenge/app/modules/users_search/ui/controller/user_search_controller.dart';
import 'package:mobile_challenge/app/modules/users_search/data/datasource/user_search_datasource.dart';
import 'package:mobile_challenge/app/modules/users_search/data/repository/user_search_repository_imp.dart';

class UserSearchInjection {
  void call(GetIt instanceGetIt) {
    instanceGetIt
      ..registerLazySingleton<UserSearchDataSource>(
        () => UserSearchDataSource(),
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
      );
  }
}
