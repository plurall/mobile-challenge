import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/model/user.dart';
import 'package:mobile_challenge/data/providers/connection.dart';
import 'package:mobile_challenge/data/remote/github_api.dart';
import 'package:mobile_challenge/presentation/components/user_card.dart';
import 'package:mobile_challenge/presentation/components/user_search.dart';
import 'package:mobile_challenge/utils/utils.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  static String routeName = '/search';
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<User> users = [];
  bool haveFoundUsers = true;

  onSearch(String search, Function onCompleted) async {
    final response = await GithubAPI.getUsers(search);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    setState(() {
      users = response;
      if (response.length > 0) {
        haveFoundUsers = true;
      } else {
        haveFoundUsers = false;
        onCompleted();
      }
    });
  }

  clearSearchFeedback(Function onChange) {
    setState(() {
      haveFoundUsers = true;
      onChange();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Utils.isConnected(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final isConnected = snapshot.data as bool;
          Provider.of<ConnectionProvider>(context, listen: false)
              .setConnection(isConnected);
          if (snapshot.data == false) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Não é possível realizar buscas, verifique a sua conexão com a Internet.',
              ),
            );
          }
          return Container(
            margin: EdgeInsets.all(10),
            child: Form(
              child: Column(
                children: [
                  UserSearch(
                    onSearch,
                    haveFoundUsers,
                    clearSearchFeedback,
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
          );
        });
  }
}
