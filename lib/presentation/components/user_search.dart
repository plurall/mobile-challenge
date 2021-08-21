import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/providers/search.dart';
import 'package:provider/provider.dart';

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
    final String initialSearchValue =
        Provider.of<SearchProvider>(context, listen: false).search;
    searchFieldController.text = initialSearchValue;
    if (initialSearchValue.length > 0) {
      widget.onPress(initialSearchValue);
    }
    searchFieldController.addListener(onSearchFieldChange);
  }

  @override
  void dispose() {
    searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Nome',
          ),
          controller: searchFieldController,
          onChanged: (value) =>
              Provider.of<SearchProvider>(context, listen: false).search =
                  value,
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
      ],
    );
  }
}
