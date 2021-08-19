import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/model/user_profile.dart';
import 'package:mobile_challenge/data/model/user_summary.dart';
import 'package:mobile_challenge/data/remote/github_api.dart';
import 'package:mobile_challenge/presentation/components/user_full_profile.dart';
import 'package:mobile_challenge/utils/utils.dart';

class UserProfileView extends StatefulWidget {
  final List<UserSummary> favoriteUsers;
  final Function updateFavorites;
  UserProfileView(this.favoriteUsers, this.updateFavorites);
  @override
  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    final UserSummary userSummary =
        ModalRoute.of(context)!.settings.arguments as UserSummary;
    final isFavoriteUser =
        Utils.isFavoriteUser(widget.favoriteUsers, userSummary);
    return Scaffold(
      appBar: AppBar(
        title: Text('Dados pessoais'),
      ),
      body: FutureBuilder<UserProfile>(
        future: GithubAPI().getUser(userSummary.login),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data;
            return UserFullProfile(user);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            isFavoriteUser ? Colors.red : Theme.of(context).primaryColor,
        child: Icon(
          isFavoriteUser ? Icons.delete : Icons.star,
        ),
        onPressed: () => widget.updateFavorites(userSummary),
      ),
    );
  }
}
