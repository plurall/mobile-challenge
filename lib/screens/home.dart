import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/widgets/button_widget.dart';
import '/widgets/list_github_users_widget.dart';
import '/widgets/text_field_widget.dart';
import '/models/github_user.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _searchUserText = TextEditingController();

  List<GitHubUser> _gitHubUserList = [];
  var url = 'https://api.github.com/users/';

  void _searchGitHubUser(String searchedUser) async {
    final responseData =
        await http.get(url + searchedUser.trim().toLowerCase());
    if (responseData.statusCode == 200) {
      //print(responseData.body);
      var selectedGitHubUser =
          GitHubUser.fromJson(json.decode(responseData.body));
      setState(() {
        _gitHubUserList.add(selectedGitHubUser);
      });
    } else {
      return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Oops!'),
          content: Text('O usuário procurado não foi encontrado.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //final screenSize = MediaQuery.of(context).size;
    //final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png',
                    scale: 3,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFieldWidget(
                  textFieldController: _searchUserText,
                  labelTextWidget: 'Usuário',
                  prefixIconDataWidget: Icons.contact_mail,
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonWidget(
                  buttonTitle: 'Procurar',
                  onButtonTapFunction: () {
                    if (_searchUserText.text.isEmpty) {
                      return;
                    } else {
                      _searchGitHubUser(_searchUserText.text);
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                GitHubUsersList(
                  _gitHubUserList,
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _gitHubUserList.clear();
            });
          },
          child: Icon(Icons.delete),
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}
