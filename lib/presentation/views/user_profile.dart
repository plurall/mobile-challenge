import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/model/user_profile.dart';
import 'package:mobile_challenge/data/remote/github_api.dart';
import 'package:mobile_challenge/presentation/components/user_info.dart';
import 'package:mobile_challenge/presentation/components/user_profile_picture.dart';

class UserProfileView extends StatefulWidget {
  @override
  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    final String login = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(login),
      ),
      body: FutureBuilder<UserProfile>(
        future: GithubAPI().getUser(login),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data;
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  UserProfilePicture(user!.avatar, user.login),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserInfo(Icons.account_box, 'Nome', user.name),
                        UserInfo(Icons.email, 'Email', user.email),
                        UserInfo(Icons.info, 'Localização', user.location),
                        UserInfo(Icons.summarize, 'Sobre', user.bio),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
