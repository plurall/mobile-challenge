import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Busca Usuários'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Pesquidar"
              ),
            ),
          ),
          Expanded(child: ListView.builder(itemBuilder: (_, index) {
            return ListTile();
          }))
        ],
      ),
    );
  }
}
