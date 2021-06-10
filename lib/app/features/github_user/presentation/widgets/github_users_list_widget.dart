import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/entities/github_user.dart';

class GithubUserListWidget extends StatelessWidget {
  final List<GithubUser> users;
  const GithubUserListWidget({
    Key key,
    @required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (_, id) {
          final user = users[id];
          return ListTile(
            onTap: () =>
                Modular.to.pushNamed('/details', arguments: user.login),
            leading: user.avatar_url == null
                ? null
                : CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar_url),
                  ),
            title: Text(user.login ?? ''),
          );
        });
  }
}
