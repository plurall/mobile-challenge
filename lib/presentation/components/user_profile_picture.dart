import 'package:flutter/material.dart';

class UserProfilePicture extends StatelessWidget {
  final String? avatar;
  final String login;

  UserProfilePicture(this.avatar, this.login);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: 200,
      child: Column(
        children: [
          ClipOval(
            child: Image.network(
              avatar!,
              fit: BoxFit.cover,
              width: 90,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              login,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
