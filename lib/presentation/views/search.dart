import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/providers/connection.dart';
import 'package:mobile_challenge/presentation/components/user_card.dart';
import 'package:mobile_challenge/presentation/components/user_search.dart';
import 'package:mobile_challenge/presentation/view_models/search_view_model.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  static String routeName = '/search';
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final searchViewModel = SearchViewModel();

  onSearch(String searchData, Function onCompleted) async {
    await searchViewModel.search(searchData);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    setState(() {});
    onCompleted();
  }

  clearSearchFeedback(Function onChange) {
    setState(() => searchViewModel.clearSearch());
    onChange();
  }

  @override
  Widget build(BuildContext context) {
    final isConnected = Provider.of<ConnectionProvider>(context).isConnected;
    final users = searchViewModel.getUsers();
    return Container(
      margin: EdgeInsets.all(10),
      child: isConnected
          ? Form(
              child: Column(
                children: [
                  UserSearch(
                    onPress: onSearch,
                    haveFoundUsers: searchViewModel.haveFoundUsers(),
                    clearSearchFeedback: clearSearchFeedback,
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
