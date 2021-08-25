import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/model/user.dart';
import 'package:mobile_challenge/data/providers/connection.dart';
import 'package:mobile_challenge/data/providers/favorite_users.dart';
import 'package:mobile_challenge/presentation/views/user_profile.dart';
import 'package:mobile_challenge/utils/utils.dart';
import 'package:provider/provider.dart';

class UserCard extends StatelessWidget {
  final User user;

  UserCard(this.user);

  void selectUser(BuildContext context) {
    Navigator.of(context)
        .pushNamed(UserProfileView.routeName, arguments: this.user);
  }

  @override
  Widget build(BuildContext context) {
    final favoriteUsers = Provider.of<FavoriteUsersProvider>(context).items;
    final isConnected = Provider.of<ConnectionProvider>(context).isConnected;
    final isFavorite = Utils.isFavoriteUser(favoriteUsers, user);
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (isConnected)
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
              if (isFavorite) Icon(Icons.star, color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}
