import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/modules/home/home_page.dart';

class AppWidget extends StatefulWidget {

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}