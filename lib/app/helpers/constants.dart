

import 'package:flutter/material.dart';

K get buildEnv => _env;
K _env;

class K {
  K._init({this.environment});

  final String environment;

  static void init({@required String value}) => _env ??= K._init(environment: value);
}