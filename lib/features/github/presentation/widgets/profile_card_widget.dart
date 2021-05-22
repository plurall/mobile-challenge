import 'package:flutter/material.dart';

class ProfileCardWidget extends StatelessWidget {
  final Widget content;

  const ProfileCardWidget({
    Key key,
    @required this.content,
  }) : super(key: key);

  // final UserProfileStore controller;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Positioned(
      top: _size.height * 0.28,
      child: Container(
        width: _size.width * 0.92,
        height: 380,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(7, 7),
              spreadRadius: 3,
            )
          ],
        ),
        child: content,
      ),
    );
  }
}