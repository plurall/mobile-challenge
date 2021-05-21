import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:mobile_challenge/pages/search_page_bloc.dart';
import 'package:mobile_challenge/pages/search_repository.dart';
import 'package:mobile_challenge/shared/custom_dio/custom_dio.dart';

import 'app_bloc.dart';
import 'app_widget.dart';

class AppModule extends ModuleWidget {
  @override
  // TODO: implement blocs
  List<Bloc<BlocBase>> get blocs => [
        Bloc((i) => AppBloc()),
      ];

  @override
  // TODO: implement dependencies
  List<Dependency> get dependencies => [Dependency((i) => CustomDio())];

  @override
  // TODO: implement view
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
