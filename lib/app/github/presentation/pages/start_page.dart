import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/app/github/presentation/search_bloc.dart';
import 'package:mobile_challenge/app/github/presentation/state/state.dart';
import 'package:mobile_challenge/app/github/presentation/widgets/search_widget.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends ModularState<StartPage, SearchBloc> {
  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 10,
        ),
        child: Column(
          children: [
            SearchWidget(
              onChanged: bloc.add,
            ),
            Expanded(
              child: StreamBuilder<GitHubState>(
                stream: bloc.stream,
                builder: (context, snapshot) {
                  if (bloc.state is GitHubStart) {
                    return Center(
                      child: Text('Digite o nome do usário'),
                    );
                  }

                  if (bloc.state is GitHubError) {
                    return Center(
                      child: Text('Erro ao realizar a busca do usário'),
                    );
                  }

                  if (bloc.state is GitHubLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final list = (bloc.state as GitHubSuccess).list;
                  return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (_, id) {
                        final item = list[id];
                        return ListTile(
                          onTap: () => Modular.to
                              .pushNamed('/details', arguments: item.login),
                          leading: item.avatar_url == null
                              ? null
                              : CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(item.avatar_url!),
                                ),
                          title: Text(item.login ?? ''),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
