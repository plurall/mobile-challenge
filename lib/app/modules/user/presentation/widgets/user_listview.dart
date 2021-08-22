import 'package:flutter/material.dart';

import '../../domain/entities/user_entity.dart';
import 'user_tile.dart';

class UserListView extends StatelessWidget {
  final List<UserEntity> users;
  final EdgeInsets padding;

  const UserListView({required this.users, this.padding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: padding,
      itemCount: users.length,
      itemBuilder: (_, index) {
        final user = users[index];
        return UserTile(user);
      }
    );
  }
}