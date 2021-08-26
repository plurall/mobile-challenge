import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/core/config/application_start_config.dart';
import 'package:mobile_challenge/app/features/presentation/ui/github_search_page.dart';

void main() async {
  final appConfig = ApplicationStartConfig();
  await appConfig.configureApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Github Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GithubSearchPage(),
    );
  }
}
