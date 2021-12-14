import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CircularProgressIndicator(),
      height: 150.0,
      width: 150.0,
    );
  }
}
