import 'package:flutter/material.dart';

class NoUserFoundWidget extends StatelessWidget {
  final String message;

  const NoUserFoundWidget({
    Key key,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          fontSize: 20,
          color: Colors.grey,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}