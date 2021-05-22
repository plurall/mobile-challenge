import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String text;
  MessageWidget({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}
