import 'package:flutter/material.dart';
import 'package:mobile_challenge/blocs/get_users_git/get_users_git.bloc.dart';
import 'package:mobile_challenge/models/response/get_users_git.model.dart';
import 'package:mobile_challenge/pages/widgets/details_user_page.widget.dart';
import 'package:mobile_challenge/pages/widgets/generic_error_display.widget.dart';
import 'package:mobile_challenge/pages/widgets/search_user.widget.dart';
import 'package:provider/provider.dart';

class ListUsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<GetUsersGitBloc>(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          child: SearchUser(),
        ),
        Expanded(
          child: Container(
            child: StreamBuilder<List<GetUsersGitModel>>(
              stream: _bloc.allUsers$,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: GenericErrorDisplay(
                        onTryAgain: _bloc.getAllUsers,
                      ),
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data.isEmpty) {
                  return Center(
                    child: Text(
                      'Nenhum usuário encontrado',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }
                var data = snapshot.data;
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final item = data[index];
                          return InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DetailsUserPage(
                                  userLogin: item.login,
                                  bloc: _bloc,
                                ),
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(
                                left: 8.0,
                                right: 8.0,
                                top: 4,
                                bottom: 4,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(2.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF000000)
                                        .withOpacity(0.10),
                                    blurRadius: 1,
                                    offset: const Offset(0, 1),
                                  )
                                ],
                              ),
                              child: Card(
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      height: 80,
                                      width: 80,
                                      child: Image.network(item.avatar_url),
                                    ),
                                    Expanded(
                                      child: Text(
                                        item.login,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
