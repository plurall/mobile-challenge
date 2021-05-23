
import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/page/main_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Challenge',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        buttonTheme: const ButtonThemeData(
          alignedDropdown: true,
          padding: EdgeInsets.all(8),
          minWidth: 12,
        ),
        primaryColor: Colors.blue,
        accentColor:Colors.blueAccent,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          headline6: TextStyle(
            fontSize: 22,
            letterSpacing: 0.15,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          bodyText2: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          caption: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w200,
            color: Colors.red,
          ),
        ),
      ),
      home: MainPage(),
    );
  }
}
