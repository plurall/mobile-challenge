import 'package:flutter/material.dart';
import 'package:mobile_challenge/blocs/get_users_git/get_users_git.bloc.dart';
import 'package:mobile_challenge/helpers/build_information.widget.dart';
import 'package:mobile_challenge/models/response/get_selected_user.model.dart';
import 'package:mobile_challenge/pages/widgets/generic_error_display.widget.dart';

class DetailsUserPage extends StatelessWidget {
  const DetailsUserPage({
    this.userLogin,
    this.bloc,
  });
  final String userLogin;
  final GetUsersGitBloc bloc;

  @override
  Widget build(BuildContext context) {
    bool result;
    bloc.getSelectedUser(userLogin);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
            bloc.clearSelectedUser();
          },
        ),
        title: Text('Detalhes do Usuário'),
      ),
      body: Container(
        alignment: Alignment.center,
        height: double.maxFinite,
        color: Colors.grey[200],
        child: SingleChildScrollView(
          child: StreamBuilder<GetSelectedUserModel>(
            stream: bloc.selectedUser$,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: GenericErrorDisplay(
                      onTryAgain: bloc.getAllUsers,
                    ),
                  ),
                );
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data == null) {
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
                  _buildProfile(data),
                  Container(
                    width: 230,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        result = await bloc.saveFavoriteUser(data);
                        if (result == true) {
                          _showSnackBar(
                              context, 'Usuário favoritado com sucesso');
                        } else {
                          _showSnackBar(
                              context, 'Usuário já se encontra favoritado');
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue[700]),
                      ),
                      icon: Icon(Icons.star_border_outlined),
                      label: Text('Adicionar aos Favoritos'),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 230,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        bloc.clearSelectedUser();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue[700]),
                      ),
                      icon: Icon(Icons.arrow_back),
                      label: Text('Voltar'),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _showSnackBar(context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ));
  }

  _buildProfile(GetSelectedUserModel data) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(15),
      child: Card(
        child: Column(
          children: [
            if (data.avatar_url != null)
              Container(
                margin: EdgeInsets.only(top: 25, bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 110,
                width: 110,
                child: Image.network(data.avatar_url),
              ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildInformation(title: 'Nome', information: data.login),
                  BuildInformation(
                      title: 'Email', information: data.email ?? 'Não possui'),
                  BuildInformation(
                      title: 'Localização',
                      information: data.location ?? 'Não possui'),
                  BuildInformation(
                      title: 'Bio', information: data.bio ?? 'Não possui'),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
