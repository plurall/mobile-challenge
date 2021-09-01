import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_challenge/data/models/user.dart';
import 'package:mobile_challenge/data/providers/connection.dart';
import 'package:mobile_challenge/data/providers/favorite_users.dart';
import 'package:mobile_challenge/presentation/components/user_full_profile.dart';
import 'package:mobile_challenge/presentation/view_models/user_profile_view_model.dart';
import 'package:provider/provider.dart';

class UserProfileView extends StatefulWidget {
  static String routeName = '/user-profile';
  @override
  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  final viewModel = GetIt.instance.get<UserProfileViewModel>();

  @override
  Widget build(BuildContext context) {
    final isConnected = Provider.of<ConnectionProvider>(context).isConnected;
    final favoriteUsersProvider = Provider.of<FavoriteUsersProvider>(context);
    final user = ModalRoute.of(context)!.settings.arguments as User;
    final isFavorite = favoriteUsersProvider.isFavorite(user);
    late User _fullUserProfile;

    return Scaffold(
      appBar: AppBar(
        title: Text('Dados pessoais'),
      ),
      body: isConnected
          ? FutureBuilder<User>(
              future: viewModel.getUser(user.login),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _fullUserProfile = snapshot.data as User;
                  return UserFullProfile(_fullUserProfile);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return Center(child: CircularProgressIndicator());
              },
            )
          : UserFullProfile(user),
      floatingActionButton: isConnected
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
              ),
              onPressed: () => {
                favoriteUsersProvider.toogleFavorite(_fullUserProfile),
              },
            )
          : Container(),
    );
  }
}
