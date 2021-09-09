import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mobile_challenge/data/providers/connection.dart';

class UserProfilePicture extends StatelessWidget {
  final String? avatar;
  final String login;
  const UserProfilePicture(this.avatar, this.login);

  @override
  Widget build(BuildContext context) {
    final isConnected = Provider.of<ConnectionProvider>(context).isConnected;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: 200,
      child: Column(
        children: [
          ClipOval(
            child: isConnected
                ? Image.network(
                    avatar!,
                    fit: BoxFit.cover,
                    width: 90,
                  )
                : const Image(
                    image: AssetImage('assets/images/avatar.png'),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
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
