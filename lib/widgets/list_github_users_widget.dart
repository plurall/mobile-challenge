import 'package:flutter/material.dart';

import '/models/github_user.dart';
import '/screens/github_user_screen.dart';

class GitHubUsersList extends StatelessWidget {
  final List<GitHubUser> gitHubUserList;

  GitHubUsersList(
    this.gitHubUserList,
  );

  void goToGitHubUserPage(BuildContext ctx, int id) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) => GithubUserScreen(
          githubUserList: gitHubUserList,
          idSelectedGithubUser: id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () {
              goToGitHubUserPage(context, gitHubUserList[index].id.toInt());
            },
            child: Card(
              margin: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 5,
              ),
              elevation: 5,
              child: ListTile(
                leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(gitHubUserList[index].avatarUrl)),
                title: Text(
                  gitHubUserList[index].login.toString(),
                ),
                subtitle: Text(
                  gitHubUserList[index].htmlUrl.toString(),
                ),
              ),
            ),
          );
        },
        itemCount: gitHubUserList.length,
      ),
    );
  }
}
