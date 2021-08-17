import 'package:mobile_challenge/app/views/search/components/header.dart';
import 'package:mobile_challenge/app/views/search/components/body.dart';
import 'package:mobile_challenge/device/connection.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController = new TextEditingController();
  bool dialVisible = true;

  Future<void> _search(String user) async {
    if (user.isNotEmpty)
      if (await Connection().checkConnection()) {
        setState(() {
          _searchController.text;
        });
      } else {
        Toast.show('C E L U L A R   S E M   C O N E X Ã O', context,
            duration: 3, gravity: Toast.TOP);
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _appBar(height) => PreferredSize(
    preferredSize: Size(MediaQuery.of(context).size.width, height + 80),
    child: Header(height, _searchController, _search),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(AppBar().preferredSize.height),
        body: _searchController.text == ''
            ? Center(
          child: Text('Informe o usuário ...'),
        )
            : RefreshIndicator(
          onRefresh: () async {
            _search(_searchController.text);
          },
          child: Body(_searchController),
        ));
  }
}
