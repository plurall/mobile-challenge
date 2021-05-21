import 'package:flutter/material.dart';
import 'package:mobile_challenge/features/github/domain/entities/user_entity.dart';
import 'package:mobile_challenge/features/github/presentation/pages/user_profile_page.dart';

class UserCard extends StatelessWidget {
  final UserEntity user;
  final Function callback;

  const UserCard({
    Key key,
    @required this.user,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => UserProfilePage(username: user.login)));
        callback != null ? callback() : null;
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[300],
                foregroundImage: NetworkImage(user.avatarUrl),
              ),
              SizedBox(width: 20),
              Text(user.login),
            ],
          ),
        ),
      ),
    );
  }
}
