import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/remote/github_api.dart';
import 'package:mobile_challenge/data/model/user.dart';
import 'package:mobile_challenge/presentation/components/user_card.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String searchField = '';
  List<User> users = [];

  onSearch() async {
    final response = await GithubAPI().getUsers(searchField);
    setState(() {
      users = response;
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
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Nome',
                  ),
                  initialValue: searchField,
                  onChanged: (value) => searchField = value,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('Buscar'),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    onPressed: () => onSearch(),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(20),
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
