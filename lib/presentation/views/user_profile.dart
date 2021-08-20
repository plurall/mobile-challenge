import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/model/user_profile.dart';
import 'package:mobile_challenge/data/model/user_summary.dart';
import 'package:mobile_challenge/data/providers/favorite_users.dart';
import 'package:mobile_challenge/data/remote/github_api.dart';
import 'package:mobile_challenge/presentation/components/user_full_profile.dart';
import 'package:mobile_challenge/utils/utils.dart';
import 'package:provider/provider.dart';

class UserProfileView extends StatefulWidget {
  static String routeName = '/user-profile';
  @override
  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    final favoriteUsersProvider = Provider.of<FavoriteUsersProvider>(context);
    final favoriteUsers = favoriteUsersProvider.items;
    final UserSummary userSummary =
        ModalRoute.of(context)!.settings.arguments as UserSummary;
    final isFavoriteUser = Utils.isFavoriteUser(favoriteUsers, userSummary);
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
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          isFavoriteUser ? Icons.star_border : Icons.star,
        ),
        onPressed: () => favoriteUsersProvider.add(userSummary),
      ),
    );
  }
}
