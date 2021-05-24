import 'package:flutter/material.dart';
import 'package:mobile_challenge/utils/palette.dart';

class SearchBar extends StatelessWidget {
  SearchBar({@required this.controller, @required this.onclick});

  final TextEditingController controller;
  final void Function() onclick;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 16),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                cursorColor: Palette.darkWhiteText,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Palette.darkWhiteText),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Palette.darkWhiteText),
                  ),
                  hintText: "Search",
                  hintStyle: TextStyle(color: Palette.darkGrayText),
                ),
                style: TextStyle(
                    color: Palette.darkWhiteText,
                    decorationColor: Palette.darkWhiteText),
              ),
            ),
            IconButton(
              onPressed: onclick,
              icon: Icon(
                Icons.search,
                color: Palette.darkWhiteText,
              ),
            )
          ],
        ),
      );
}
