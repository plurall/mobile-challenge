import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_api/utils/routes.dart';

void main() {
  runApp(GetMaterialApp(
    theme: ThemeData(primarySwatch: Colors.purple),
    routes: Routes.pages,
    initialRoute: Routes.INITIAL_ROUTE,
  ));
}
