import 'package:flutter/material.dart';
import 'package:github_search/screens/home.dart';

import 'screens/bottom_navigation_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Search',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: BottomNavigationScreen(),
      onUnknownRoute: (settings) => MaterialPageRoute(builder: (_) => Home()),
    );
  }
}
