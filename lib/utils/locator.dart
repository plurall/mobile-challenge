import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_challenge/services/get_users_git_impl.service.dart';
import 'package:mobile_challenge/services/interfaces/get_users_git.service.dart';

setupLocator() async {
  locator.registerFactory<GetUsersGitService>(() => GetUsersGitServiceImpl());
  locator.registerLazySingleton(() => const FlutterSecureStorage());
}

final GetIt locator = GetIt.instance;
