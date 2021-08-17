import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/model/user.dart';

class UserCard extends StatelessWidget {
  final User user;

  UserCard(this.user);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        color: Colors.grey,
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              user.avatar,
              width: 50,
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                user.login,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
