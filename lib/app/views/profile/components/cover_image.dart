import 'package:flutter/material.dart';

class CoverImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height / 7.1,
      decoration: BoxDecoration(
        color: Colors.amberAccent,
      ),
    );
  }
}
