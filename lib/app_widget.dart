import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';


class AppWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF3B6DEF),
        accentColor: Color(0xFF0E359C)
      ),
    initialRoute: "/",
    ).modular();
  }
}
