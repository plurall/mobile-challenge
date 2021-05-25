import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/core/theme/app_colors.dart';
import 'package:mobile_challenge/app/github/presentation/state/state.dart';
import 'package:mobile_challenge/app/github/presentation/widgets/text_widget.dart';

import '../search_user_bloc.dart';

class DetailsUserPage extends StatefulWidget {
  final String userName;

  const DetailsUserPage({Key? key, required this.userName}) : super(key: key);
  @override
  _DetailsUserPageState createState() => _DetailsUserPageState();
}

class _DetailsUserPageState
    extends ModularState<DetailsUserPage, SearchUserBloc> {
  @override
  void initState() {
    bloc.add(widget.userName);
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
        leading: BackButton(
          onPressed: () {
            GitHubStart();
            Modular.to.maybePop();
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 10,
        ),
        child: StreamBuilder<GitHubState>(
          stream: bloc.stream,
          builder: (context, snapshot) {
            if (bloc.state is GitHubError) {
              return Center(
                child: Text('Erro ao carregar dados do usuario'),
              );
            }

            if (bloc.state is GitHubLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final user = (bloc.state as GitHubUserSuccess).user;
            return SizedBox(
              height: 400,
              child: Card(
                color: AppColors.border,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.star_outline,
                              color: AppColors.text_primary,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar_url!),
                      ),
                      SizedBox(height: 20),
                      TextWidget(
                        text: user.name,
                      ),
                      TextWidget(
                        text: user.email,
                      ),
                      TextWidget(
                        text: user.location,
                      ),
                      TextWidget(
                        text: user.bio,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
