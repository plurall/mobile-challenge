import 'package:flutter/material.dart';
import 'package:mobile_challenge/modules/user_list/presentation/user_list_page.dart';

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
      home: UserListPage(),
    );
  }
}
