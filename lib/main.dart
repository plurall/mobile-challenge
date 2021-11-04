import 'package:flutter/material.dart';
import 'package:mobile_challenge/core/init_dependencies.dart';
import 'package:mobile_challenge/favorites/utils/database_connection.dart';
import 'package:mobile_challenge/home/view/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  _initializeDB();
  setupGetIt();
  runApp(MyApp());
}

void _initializeDB() {
  DatabaseConnection.connectDB();
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github User List',
      theme: ThemeData(
        primaryColor: Colors.purple,
        accentColor: Colors.purple,
        brightness: Brightness.dark
      ),
      home: HomePage(),
    );
  }
}
