import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/common/constants/app_routes.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/entity/user_entity.dart';

class UserItemWidget extends StatelessWidget {
  final UserEntity user;
  const UserItemWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
          AppRoutes.USER_DETAIL,
          arguments: user,
        ),
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 5.0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(user.avatarUrl),
              ),
              title: Text(user.login),
              subtitle: Text(user.name),
            ),
          ),
        ),
      );
}
