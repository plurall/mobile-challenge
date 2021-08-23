import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mobile_challenge/app/data/repository/repository.dart';
import 'package:mobile_challenge/app/modules/routes/routes.dart';
import 'package:mobile_challenge/app/modules/search/search_page.dart';
import 'package:mobile_challenge/app/theme/theme.dart';

void main() async {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Pages.routes,
      theme: appThemeData,
      initialRoute: SearchPage.route,
    ),
  );
  await Repository.initStorage();
}
