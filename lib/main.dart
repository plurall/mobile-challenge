import 'package:flutter/material.dart';

import 'features/github/presentation/pages/start_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Challenge',
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.amber,
      ),
      home: StartPage(),
    );
  }
}