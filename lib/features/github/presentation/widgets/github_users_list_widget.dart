import 'package:flutter/material.dart';
import 'package:mobile_challenge/features/github/domain/entities/users_entity.dart';
import 'package:mobile_challenge/features/github/presentation/widgets/user_card_widget.dart';

class GithubUsersListWidget extends StatelessWidget {
  final UsersEntity usersEntity;
  final Function callback;

  const GithubUsersListWidget({
    Key key,
    @required this.usersEntity,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: usersEntity.users.length,
      itemBuilder: (context, index) {
        return UserCard(
          user: usersEntity.users[index],
          callback: callback,
        );
      },
    );
  }
}
