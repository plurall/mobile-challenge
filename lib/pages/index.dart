import 'package:flutter/material.dart';
import 'package:mobile_challenge/blocs/get_users_git/get_users_git.bloc.dart';
import 'package:mobile_challenge/pages/widgets/body_page.widget.dart';
import 'package:provider/provider.dart';

class GetUsersGitPage extends StatefulWidget {
  @override
  _GetUsersGitPageState createState() => _GetUsersGitPageState();
}

class _GetUsersGitPageState extends State<GetUsersGitPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  GetUsersGitBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = GetUsersGitBloc();
    _tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pesquisa Usuários GIT'),
          backgroundColor: Colors.blue[900],
          centerTitle: true,
        ),
        body: MultiProvider(
          providers: [
            Provider<GetUsersGitBloc>.value(
              value: _bloc,
            ),
          ],
          child: Container(
            child: BodyGetUsersGit(
              tabController: _tabController,
            ),
          ),
        ),
      ),
    );
  }
}
