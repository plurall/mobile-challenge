import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mobile_challenge/data/models/user.dart';
import 'package:mobile_challenge/data/providers/connection.dart';
import 'package:mobile_challenge/data/providers/favorite_users.dart';
import 'package:mobile_challenge/presentation/views/user_profile.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard(this.user);

  void selectUser(BuildContext context) {
    Navigator.of(context).pushNamed(UserProfileView.routeName, arguments: user);
  }

  @override
  Widget build(BuildContext context) {
    final favoriteUsersProvider = Provider.of<FavoriteUsersProvider>(context);
    final isConnected =
        Provider.of<ConnectionProvider>(context, listen: false).isConnected;
    final isFavorite = favoriteUsersProvider.isFavorite(user);
    return InkWell(
      onTap: () => selectUser(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(5.0),
      child: Card(
        margin: const EdgeInsets.all(5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          color: Theme.of(context).colorScheme.background,
          padding: const EdgeInsets.all(10),
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
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      user.login,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              if (isFavorite) const Icon(Icons.star, color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}
