import 'package:flutter/material.dart';

import '/models/github_user.dart';
import '/widgets/list_tile_widget.dart';

class GithubUserScreen extends StatelessWidget {
  final List<GitHubUser> githubUserList;
  final int idSelectedGithubUser;
  final IconData iconData;
  final String text;

  GithubUserScreen({
    this.githubUserList,
    this.idSelectedGithubUser,
    this.iconData,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    final githubUser = githubUserList.firstWhere(
      (githubUser) => githubUser.id == idSelectedGithubUser,
    );

    final myAppBar = AppBar(title: Text(githubUser.name.toString()));

    return SafeArea(
      child: Scaffold(
        appBar: myAppBar,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    githubUser.avatarUrl,
                  ),
                  minRadius: 50,
                  maxRadius: 75,
                ),
                ListTileWidget(
                  iconData: Icons.pin_drop,
                  text: githubUser.location.toString(),
                ),
                ListTileWidget(
                  iconData: Icons.info,
                  text: githubUser.bio.toString(),
                ),
                ListTileWidget(
                  iconData: Icons.account_box,
                  text: githubUser.name.toString(),
                ),
                ListTileWidget(
                  iconData: Icons.email,
                  text: githubUser.email.toString(),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.favorite),
          backgroundColor: Colors.pink,
        ),
      ),
    );
  }
}
