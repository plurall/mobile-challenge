import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_challenge/features/github/presentation/stores/users_store.dart';
import 'package:mobile_challenge/features/github/presentation/widgets/user_card_widget.dart';

import '../../../../injection_container.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final textController = TextEditingController();

  final controller = sl<UsersStore>();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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


