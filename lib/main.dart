import 'package:flutter/material.dart';
import 'package:mobile_challenge/core/styles/themes.dart';
import 'package:mobile_challenge/features/github/presentation/pages/splash_page.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Challenge',
      theme: AppThemes.lightTheme,
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
