import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/model/user_summary.dart';
import 'package:mobile_challenge/presentation/components/user_card.dart';

class FavoritesView extends StatelessWidget {
  final List<UserSummary> favoriteUsers;
  FavoritesView(this.favoriteUsers);
  @override
  Widget build(BuildContext context) {
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
