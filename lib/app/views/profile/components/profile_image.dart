import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  String image;
  ProfileImage(this.image);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
          width: 130.0,
          height: 130.0,
          decoration: this.image != null
              ? BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(this.image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(80.0),
              border: Border.all(
                color: Colors.white,
                width: 10.0,
              ))
              : Container()),
    );
  }
}
