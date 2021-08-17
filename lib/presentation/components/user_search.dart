import 'package:flutter/material.dart';

class UserSearch extends StatefulWidget {
  final String searchFeedback;
  final Function onPress;

  UserSearch(this.onPress, this.searchFeedback);

  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  final searchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextFormField(
        decoration: InputDecoration(
          hintText: 'Nome',
        ),
        controller: searchFieldController,
      ),
      Padding(
        padding: EdgeInsets.only(top: 10),
      ),
      Container(
        width: double.infinity,
        child: ElevatedButton(
          child: Text('Buscar'),
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
          ),
          onPressed: () => widget.onPress(searchFieldController.text),
        ),
      ),
      if (widget.searchFeedback.isNotEmpty)
        Container(
          margin: EdgeInsets.all(10),
          child: Text(
            widget.searchFeedback,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
    ]);
  }
}
