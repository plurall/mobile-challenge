import 'package:flutter/material.dart';

import '../../../../core/widget/github_user_card_widget.dart';
import '../../../../core/entities/github_user_favorite.dart';

class GithubUserFavoriteListWidget extends StatelessWidget {
  final List<GithubUserFavorite> favorite;
  const GithubUserFavoriteListWidget({Key key, @required this.favorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favorite.length,
      itemBuilder: (context, index) {
        var item = favorite[index];
        return GithubUserCardWidget(
          avatar_url: '',
          bio: item.bio,
          email: item.email,
          location: item.location,
          name: item.name,
          onTapIcon: () {},
        );
      },
    );
  }
}
