import 'package:flutter/material.dart';

import 'modules/user_list/user_list.dart';
import 'utils/palette.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Users',
      theme: ThemeData(
        primarySwatch: Palette.backgroundDarkGray,
        fontFamily: 'Segoe UI',
      ),
      home: UserList().routeToPage(),
    );
  }
}
