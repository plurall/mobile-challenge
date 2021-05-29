import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'features/utils/routes.dart';
import 'ui/components/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Set portrait orientation
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return GetMaterialApp(
      theme: makeAppTheme(),
      routes: Routes.pages,
      initialRoute: Routes.INITIAL_ROUTE,
      debugShowCheckedModeBanner: false,
    );
  }
}