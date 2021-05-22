import 'package:flutter/material.dart';
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
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF242424),
        accentColor: Colors.amber,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
