import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/model/user_profile.dart';
import 'package:mobile_challenge/data/remote/github_api.dart';

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
        title: Text('Dados de $login'),
      ),
      body: Center(
        child: FutureBuilder<UserProfile>(
          future: GithubAPI().getUser(login),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final user = snapshot.data;
              return Column(children: [
                Text('Nome: ${user!.name}'),
                Image.network(
                  user.avatar,
                  width: 50,
                ),
                Text('Email: ${user.email}'),
                Text('Bio: ${user.bio}'),
                Text('Localização: ${user.location}'),
              ]);
            } else if (snapshot.hasError) {
              return Text('Erro no carregamento: ${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
