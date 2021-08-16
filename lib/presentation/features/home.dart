import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_challenge/data/model/user.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String searchField = '';
  List<dynamic> users = [];

  onSearch() async {
    final response = await http
        .get(Uri.parse('https://api.github.com/search/users?q=$searchField'));

    //debug - dados server
    Map mapRes = jsonDecode(response.body);
    print('Response from server: $mapRes');
    //

    if (response.statusCode == 200) {
      Map jsonResponse = jsonDecode(response.body);
      setState(() {
        users =
            jsonResponse['items'].map((user) => User.fromJson(user)).toList();
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Busca de usuário'),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Nome',
                  ),
                  initialValue: searchField,
                  onChanged: (value) => searchField = value,
                ),
                Padding(padding: EdgeInsets.all(10)),
                ElevatedButton(
                  child: Text('Buscar'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: () => onSearch(),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
                  margin: EdgeInsets.all(20),
                  height: 200.0,
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return Text(users[index].login);
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
