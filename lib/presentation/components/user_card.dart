import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/model/user_summary.dart';

class UserCard extends StatelessWidget {
  final UserSummary user;

  UserCard(this.user);

  void selectUser(BuildContext context) {
    Navigator.of(context)
        .pushNamed('/user-profile', arguments: this.user.login);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectUser(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(5.0),
      child: Card(
        margin: EdgeInsets.all(5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          color: Theme.of(context).colorScheme.background,
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
