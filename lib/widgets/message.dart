import 'package:flutter/material.dart';
import 'package:mobile_challenge/utils/palette.dart';

class MessageWidget extends StatelessWidget {
  final String text;
  MessageWidget({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(color: Palette.darkWhiteText),
      ),
    );
  }
}
