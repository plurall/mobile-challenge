import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/model/user.dart';
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
    final FavoriteUsersProvider favoriteUsersProvider =
        Provider.of<FavoriteUsersProvider>(context);
    final List<User> favoriteUsers = favoriteUsersProvider.items;
    final User user = ModalRoute.of(context)!.settings.arguments as User;
    final isFavoriteUser = Utils.isFavoriteUser(favoriteUsers, user);
    return Scaffold(
      appBar: AppBar(
        title: Text('Dados pessoais'),
      ),
      body: FutureBuilder<User>(
        future: GithubAPI.getUser(user.login),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final fullUserProfile = snapshot.data;
            return UserFullProfile(fullUserProfile);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          isFavoriteUser ? Icons.star : Icons.star_border,
        ),
        onPressed: () => {
          favoriteUsersProvider.toogleFavorite(user),
        },
      ),
    );
  }
}
