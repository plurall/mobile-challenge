import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/models/user.dart';
import 'package:mobile_challenge/data/providers/connection.dart';
import 'package:mobile_challenge/data/remote/search_remote.dart';
import 'package:mobile_challenge/presentation/components/user_card.dart';
import 'package:mobile_challenge/presentation/components/user_search.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  static String routeName = '/search';
  final searchRemote = SearchRemote();
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<User> users = [];
  bool haveFoundUsers = true;

  onSearch(String search, Function onCompleted) async {
    final response = await widget.searchRemote.getUsers(search);
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
    final isConnected = Provider.of<ConnectionProvider>(context).isConnected;
    return Container(
      margin: EdgeInsets.all(10),
      child: isConnected
          ? Form(
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
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Não é possível realizar buscas, verifique a sua conexão com a Internet.',
              ),
            ),
    );
  }
}
