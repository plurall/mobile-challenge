import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/app.module.dart';
import 'package:mobile_challenge/app/app_bloc.dart';
import 'package:mobile_challenge/pages/search_module.dart';
import 'package:mobile_challenge/pages/search_page_bloc.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesquisa"),
        actions: [
          Switch(
              value: AppModule.to.bloc<AppBloc>().isDark,
              onChanged: (value) =>
                  {AppModule.to.bloc<AppBloc>().changeTheme()})
        ],
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            {SearchModule.to.bloc<SearchPageBlock>().getListUsers('Withi')},
      ),
    );
  }
}
