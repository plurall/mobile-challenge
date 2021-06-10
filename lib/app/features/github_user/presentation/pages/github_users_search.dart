import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../bloc/github_user_list_bloc.dart';
import '../bloc/github_user_or_user_details_event.dart';
import '../bloc/github_users_list_state.dart';
import '../widgets/github_users_list_widget.dart';
import '../widgets/search_widget.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends ModularState<StartPage, GithubUserListBloc> {
  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start Page'),
        actions: [
          IconButton(
            onPressed: () => Modular.to.pushNamed('/favorite/'),
            icon: Icon(Icons.star),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 10,
        ),
        child: BlocProvider(
          create: (_) => bloc,
          child: Column(
            children: [
              SearchWidget(
                onChanged: (value) {
                  bloc.add(GetGitHubUserOrUserDetails(value));
                },
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: BlocBuilder<GithubUserListBloc, GithubUsersListState>(
                  builder: (context, state) {
                    if (state is Empty) {
                      return Center(
                        child: Text('Digite o nome do usário'),
                      );
                    }

                    if (state is Error) {
                      return Center(
                        child: Text(state.message),
                      );
                    }

                    if (state is Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is Loaded) {
                      return GithubUserListWidget(users: state.users);
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
