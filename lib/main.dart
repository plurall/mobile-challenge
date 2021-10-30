import 'package:flutter/material.dart';
import 'package:mobile_challenge/home/view/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github User List',
      theme: ThemeData(
        primaryColor: Colors.purple,
        accentColor: Colors.purple,
        brightness: Brightness.dark
      ),
      home: HomePage(),
    );
  }
}
