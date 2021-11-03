import 'package:flutter/material.dart';
import 'package:mobile_challenge/controllers/search_controller.dart';
import 'package:provider/src/provider.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController controller;

  const SearchBar({Key key, @required this.controller}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isOpen
            ? Expanded(
                child: TextField(
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) {
                    context.read<SearchController>().fetchUsers(value);
                    setState(() {
                      isOpen = !isOpen;
                    });
                  },
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  autofocus: true,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  maxLines: 1,
                ),
              )
            : Text('Github', style: TextStyle(color: Colors.white)),
        IconButton(
            onPressed: () {
              setState(() {
                isOpen = !isOpen;
              });
            },
            icon: Icon(isOpen ? Icons.close : Icons.search))
      ],
    );
  }
}
