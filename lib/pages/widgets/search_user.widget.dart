import 'package:flutter/material.dart';
import 'package:mobile_challenge/blocs/get_users_git/get_users_git.bloc.dart';
import 'package:provider/provider.dart';

class SearchUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _searchUserController = TextEditingController();
    final _bloc = Provider.of<GetUsersGitBloc>(context);
    return Row(
      children: [
        Expanded(
          child: Container(
            child: TextFormField(
              controller: _searchUserController,
              onChanged: _bloc.onChangeSearchUser,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                hintText: 'Pesquisar usuário',
              ),
            ),
          ),
        ),
        Tooltip(
          message: 'Toque aqui para pesquisar',
          child: Container(
            margin: EdgeInsets.all(10),
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue[700],
                onPrimary: Colors.white,
              ),
              onPressed: () {
                _bloc.getAllUsers();
              },
              child: Icon(
                Icons.search,
                size: 30,
              ),
            ),
          ),
        )
      ],
    );
  }
}
