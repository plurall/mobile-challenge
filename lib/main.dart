import 'package:mobile_challenge/app/views/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      title: 'Mobile-Challenge',
      debugShowCheckedModeBanner: false,
    );
  }
}


