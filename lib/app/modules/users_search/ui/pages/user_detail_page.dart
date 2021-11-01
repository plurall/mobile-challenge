import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/modules/users_search/domain/entity/user_entity.dart';

class UserDetailPage extends StatelessWidget {
  const UserDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userEntity = ModalRoute.of(context)!.settings.arguments as UserEntity;
    final mediaQuery = MediaQuery.of(context);
    final availableHeight = mediaQuery.size.height - mediaQuery.padding.top;
    return Scaffold(
      appBar: AppBar(
        title: Text(userEntity.login),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: availableHeight * 0.50,
              width: double.infinity,
              child: Image.network(
                userEntity.avatarUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              userEntity.location,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(userEntity.bio),
            SizedBox(
              height: 10.0,
            ),
            Text(userEntity.name),
            // Text(userEntity.email),
          ],
        ),
      ),
    );
  }
}
