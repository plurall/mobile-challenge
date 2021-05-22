import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final IconData iconData;
  final String text;

  ListTileWidget({
    this.iconData,
    this.text,
  });

  Widget textVerifier(BuildContext ctx, String text) {
    if (text == 'null') {
      return Text(
        'Sem informações',
        style: TextStyle(
          fontSize: 16,
        ),
      );
    } else {
      return Text(
        text,
        style: TextStyle(
          fontSize: 16,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
      ),
      title: textVerifier(context, text),
    );
  }
}
