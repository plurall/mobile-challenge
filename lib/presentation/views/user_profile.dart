import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/model/user_profile.dart';
import 'package:mobile_challenge/data/remote/github_api.dart';
import 'package:mobile_challenge/presentation/components/user_full_profile.dart';

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
        title: Text('Dados pessoais'),
      ),
      body: FutureBuilder<UserProfile>(
        future: GithubAPI().getUser(login),
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
        child: Icon(Icons.star),
        onPressed: () => {},
      ),
    );
  }
}
