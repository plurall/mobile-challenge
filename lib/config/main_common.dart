import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/api/dio/logger_container.dart';
import 'package:mobile_challenge/app/helpers/constants.dart';

import '../app/app_widget.dart';

final logger = LoggerContainer().init();

void mainCommon(String environment) {
  K.init(value: environment);
  assert(buildEnv != null);
  runApp(AppWidget());
}
