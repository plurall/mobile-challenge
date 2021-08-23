import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/model/user.dart';
import 'package:mobile_challenge/data/remote/github_api.dart';
import 'package:mobile_challenge/presentation/components/user_card.dart';
import 'package:mobile_challenge/presentation/components/user_search.dart';

class SearchView extends StatefulWidget {
  static String routeName = '/search';
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<User> users = [];
  bool haveFoundUsers = true;

  onSearch(String search, Function onCompleted) async {
    final response = await GithubAPI().getUsers(search);
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
  }
}
