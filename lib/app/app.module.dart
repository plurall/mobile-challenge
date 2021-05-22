import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'app_bloc.dart';
import 'app_widget.dart';
import 'shared/custom_dio/custom_dio.dart';

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
