import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  SearchBar({
    @required this.onChanged,
    @required this.onPressed,
  });

  final Function(String text) onChanged;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged: onChanged,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: onPressed,
          ),
          hintText: 'Pesquise usuários do Github',
        ),
      ),
    );
  }
}
