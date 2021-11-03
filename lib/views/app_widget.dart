import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/controllers/search_controller.dart';
import 'package:mobile_challenge/controllers/user_controller.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SearchController()),
        ChangeNotifierProvider(create: (context) => UserController())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Desafio Github',
        theme: ThemeData(primaryColor: Colors.blue),
      ).modular(),
    );
  }
}
