import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/model/user_summary.dart';
import 'package:mobile_challenge/data/providers/favorite_users.dart';
import 'package:mobile_challenge/presentation/components/user_card.dart';
import 'package:provider/provider.dart';

class FavoritesView extends StatelessWidget {
  static String routeName = '/favorites';
  @override
  Widget build(BuildContext context) {
    final List<UserSummary> favoriteUsers =
        Provider.of<FavoriteUsersProvider>(context).items;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: favoriteUsers.length,
        itemBuilder: (context, index) {
          return UserCard(favoriteUsers[index]);
        },
      ),
    );
  }
}
