import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_challenge/features/github/domain/entities/user_entity.dart';
import 'package:mobile_challenge/features/github/presentation/pages/user_profile_page.dart';
import 'package:mobile_challenge/features/github/presentation/stores/users_store.dart';
import 'package:mobile_challenge/injection_container.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final textController = TextEditingController();
  final controller = sl<UsersStore>();
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final controller = sl<UsersStore>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () =>
                            controller.getUsersWithName(textController.text),
                      )),
                    ),
                  ),
                ),
              ],
            ),
            Observer(builder: (_) {
              return Expanded(
                child: _getWidgetBasedOnStatus(controller),
              );
            }),
          ],
        ),
      ),
    );
  }
}

Widget _getWidgetBasedOnStatus(UsersStore controller) {
  if (controller.status is Idle) {
    return Center();
  } else if (controller.status is Loading) {
    return Center(child: CircularProgressIndicator());
  } else if (controller.status is Error) {
    return Text(controller.status.props.first);
  }

  return ListView.builder(
    physics: BouncingScrollPhysics(),
    itemCount: controller.users.users.length,
    itemBuilder: (context, index) {
      return UserCard(
        user: controller.users.users[index],
      );
    },
  );
}

class UserCard extends StatelessWidget {
  final UserEntity user;

  const UserCard({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => UserProfilePage(username: user.login))),
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                foregroundImage: NetworkImage(user.avatarUrl),
              ),
              SizedBox(width: 20),
              Text(user.login),
            ],
          ),
        ),
      ),
    );
  }
}
