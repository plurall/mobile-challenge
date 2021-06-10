import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../bloc/github_user_details_bloc.dart';
import '../bloc/github_user_or_user_details_event.dart';
import '../bloc/github_user_state.dart';
import '../widgets/github_user_detail_widget.dart';

class GithubUserDetailsPage extends StatefulWidget {
  final String githubUserName;

  const GithubUserDetailsPage({Key key, @required this.githubUserName})
      : super(key: key);

  @override
  _GithubUserDetailsStatePage createState() => _GithubUserDetailsStatePage();
}

class _GithubUserDetailsStatePage
    extends ModularState<GithubUserDetailsPage, GithubUserDetailsBloc> {
  @override
  void initState() {
    bloc.add(GetGitHubUserOrUserDetails(widget.githubUserName));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
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
              SizedBox(
                height: 10,
              ),
              BlocBuilder<GithubUserDetailsBloc, GithubUserDetailsState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return Container();
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
                    return GithubUserDetailsWidget(
                      user: state.user,
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
