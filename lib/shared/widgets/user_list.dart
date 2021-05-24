import 'package:flutter/material.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

import 'user_card.dart';

class UserListWidget extends StatelessWidget {
  UserListWidget(
      {@required this.length, @required this.list, @required this.callback});

  final int length;
  final List<User> list;
  final void Function(String nickname) callback;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: length,
        itemBuilder: (ctx, index) {
          return UserCardWidget(
            list[index],
            callback,
          );
        },
      );
}
