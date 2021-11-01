import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/app_widget.dart';

import 'app/modules/users_search/di.dart';

void main() {
  GetIt getIt = GetIt.instance;
  final userSearchInjection = UserSearchInjection();
  userSearchInjection.call(getIt);
  runApp(AppWidget());
}
