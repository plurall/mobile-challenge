import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_challenge/core/network/network_info.dart';
import 'package:mobile_challenge/features/github/data/datasources/github_remote_data_source.dart';
import 'package:mobile_challenge/features/github/data/repositories/github_repository_impl.dart';
import 'package:mobile_challenge/features/github/domain/repositories/github_repository.dart';
import 'package:mobile_challenge/features/github/domain/usecases/get_user_usecase.dart';
import 'package:mobile_challenge/features/github/domain/usecases/get_users_with_name_usecase.dart';
import 'package:mobile_challenge/features/github/presentation/stores/users_store.dart';
import 'package:http/http.dart' as http;

import 'features/github/presentation/stores/user_profile_store.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Mobx
  sl.registerFactory(() => UsersStore(sl()));
  sl.registerFactory(
    () => UserProfileStore(
      getUserUseCase: sl(),
      getBookmarkUsersUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetUsersWithNameUseCase(sl()));
  sl.registerLazySingleton(() => GetUserUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<GithubRepository>(
    () => GithubRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<GithubRemoteDataSource>(
      () => GithubRemoteDataSourceImpl(client: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
