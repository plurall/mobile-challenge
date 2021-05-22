import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/app.module.dart';
import 'package:mobile_challenge/app/app_bloc.dart';
import 'package:mobile_challenge/app/pages/search/search_module.dart';
import 'package:mobile_challenge/app/pages/user_detail/user_detail_page.dart';

import 'package:mobile_challenge/shared/dark.theme.dart';
import 'package:mobile_challenge/shared/ligth.theme.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        initialData: false,
        stream: AppModule.to.bloc<AppBloc>().theme,
        builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: snapshot.data! ? darkTheme : ligthTheme,
            home: SearchModule(),
            initialRoute: "/",
            routes: {'/userDetail': (context) => UserDetailPage()},
          );
        });
  }
}
