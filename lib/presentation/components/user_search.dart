import 'package:flutter/material.dart';

class UserSearch extends StatefulWidget {
  final String searchFeedback;
  final Function onPress;
  final Function clearSearchFeedback;

  UserSearch(this.onPress, this.searchFeedback, this.clearSearchFeedback);

  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  final searchFieldController = TextEditingController();

  onSearchFieldChange() {
    widget.clearSearchFeedback();
  }

  @override
  void initState() {
    super.initState();
    searchFieldController.addListener(onSearchFieldChange);
  }

  @override
  void dispose() {
    searchFieldController.dispose();
    super.dispose();
  }

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Buscar'),
              Icon(Icons.search),
            ],
          ),
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
