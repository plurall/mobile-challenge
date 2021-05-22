import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/model/result_search.dart';

class Search extends SearchDelegate {
  late Items selectedResult;

  late final List<Items> listExample;
  Search(this.listExample)
      : super(
            searchFieldLabel: "Procure pelo nome",
            searchFieldStyle: TextStyle(color: Colors.white));

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
        hintColor: Colors.white,
        indicatorColor: Colors.white,
        textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(icon: Icon(Icons.close), onPressed: () => {query = ''}),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => {Navigator.pop(context)});
  }

  @override
  Widget buildResults(BuildContext context) {
    return Card(
        child: ListTile(
            title: Text(selectedResult.login!),
            subtitle: Text(selectedResult.url!),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(selectedResult.avatarUrl!),
            ),
            trailing: Icon(Icons.star)));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
