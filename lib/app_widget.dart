import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //navigatorKey: Modular.,
      debugShowCheckedModeBanner: false,
      title: 'Github Search Users',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: Modular.initialRoute,
      //onGenerateRoute: Modular.,
    ).modular();
  }
}
