import 'package:mobile_challenge/app/app_controller.dart';
import 'package:mobile_challenge/app/app_theme.dart';
import 'package:mobile_challenge/app/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AppController.instance.themeSwitch,
      builder: (context, isDark, child) {
        return MaterialApp(
          title: 'Flutter App',
          debugShowCheckedModeBanner: false,
          theme: isDark ? AppTheme.darkMode : AppTheme.lightMode,
          home: HomePage(),
        );
      },
    );
  }
}
