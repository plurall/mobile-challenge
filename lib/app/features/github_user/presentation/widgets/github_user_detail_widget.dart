import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/entities/github_user_favorite.dart';
import '../../../../core/widget/github_user_card_widget.dart';
import '../../domain/entities/github_user_details.dart';
import '../bloc/github_user_or_user_details_event.dart';
import '../bloc/set_github_user_favorite.dart';

class GithubUserDetailsWidget extends StatefulWidget {
  final GithubUserDetails user;

  const GithubUserDetailsWidget({Key key, this.user}) : super(key: key);

  @override
  _GithubUserDetailsWidgetState createState() =>
      _GithubUserDetailsWidgetState();
}

class _GithubUserDetailsWidgetState
    extends ModularState<GithubUserDetailsWidget, SetGithubUserFavoriteBloc> {
  GithubUserFavorite githubUserFavorite() {
    return GithubUserFavorite(
      avatar_url: widget.user.avatar_url,
      bio: widget.user.bio,
      email: widget.user.email,
      location: widget.user.location,
      name: widget.user.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GithubUserCardWidget(
        avatar_url: widget.user.avatar_url,
        bio: widget.user.bio,
        email: widget.user.email,
        location: widget.user.location,
        name: widget.user.name,
        onTapIcon: () {
          controller.add(SetGitHubUserFavorites(githubUserFavorite()));
          //controller.call(githubUserFavorite);
        });
  }
}
