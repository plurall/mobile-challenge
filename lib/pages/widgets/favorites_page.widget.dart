import 'package:flutter/material.dart';
import 'package:mobile_challenge/blocs/get_users_git/get_users_git.bloc.dart';
import 'package:mobile_challenge/helpers/build_information.widget.dart';
import 'package:mobile_challenge/models/user_storage.model.dart';
import 'package:mobile_challenge/pages/widgets/details_user_page.widget.dart';
import 'package:mobile_challenge/pages/widgets/generic_error_display.widget.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<GetUsersGitBloc>(context);
    _bloc.loadLocalFavoritedUsers();
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.grey[200],
            child: StreamBuilder<List<UserStorageModel>>(
              stream: _bloc.listLocalUsers$,
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
                if (!snapshot.hasData || snapshot.data.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhum usuário favorito encontrado',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }

                var data = snapshot.data;
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final item = data[index];
                          return Row(
                            children: [
                              Expanded(
                                child: InkWell(
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
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                BuildInformation(
                                                  title: 'Nome',
                                                  information: item.login,
                                                  fontSizeTitle: 16,
                                                  fontSizeInformation: 15,
                                                ),
                                                BuildInformation(
                                                  title: 'Email',
                                                  information: item.email ??
                                                      'Não possui',
                                                  fontSizeTitle: 16,
                                                  fontSizeInformation: 15,
                                                ),
                                                BuildInformation(
                                                  title: 'Localização',
                                                  information: item.location ??
                                                      'Não possui',
                                                  fontSizeTitle: 16,
                                                  fontSizeInformation: 15,
                                                ),
                                                BuildInformation(
                                                  title: 'Bio',
                                                  information:
                                                      item.bio ?? 'Não possui',
                                                  fontSizeTitle: 16,
                                                  fontSizeInformation: 15,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Tooltip(
                                message: 'Remover Favorito',
                                child: Container(
                                  margin: EdgeInsets.all(6),
                                  child: IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      _bloc.removeLocalUser(item.login);
                                      _showSnackBar(context);
                                    },
                                  ),
                                ),
                              )
                            ],
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

  _showSnackBar(context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Usuário removido com sucesso'),
      duration: const Duration(seconds: 2),
    ));
  }
}
