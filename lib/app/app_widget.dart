import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/app_theme.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Challenge',
      theme: ThemeData(
        primaryColor: AppTheme.appColor,
        accentColor: AppTheme.appColor,
        primaryColorDark: AppTheme.appColor,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
    ).modular();
  }
}
