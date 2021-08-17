import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/remote/github_api.dart';
import 'package:mobile_challenge/data/model/user.dart';
import 'package:mobile_challenge/presentation/components/user_card.dart';
import 'package:mobile_challenge/presentation/components/user_search.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<User> users = [];
  String searchFeedback = '';

  onSearch(String search) async {
    if (search.isEmpty) {
      setState(() {
        users = [];
        searchFeedback = 'Digite o nome do usuário';
      });
      return;
    }
    final response = await GithubAPI().getUsers(search);
    setState(() {
      users = response;
      searchFeedback = response.length > 0
          ? ''
          : 'Não foram encontrados usuários com este nome';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Busca de usuários'),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Form(
            child: Column(
              children: [
                UserSearch(
                  onSearch,
                  searchFeedback,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return UserCard(users[index]);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
