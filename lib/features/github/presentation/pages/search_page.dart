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
  final formKey = GlobalKey<FormState>();
  final controller = sl<UsersStore>();

  _searchUsers() {
    if (formKey.currentState.validate()) {
      controller.getUsersWithName(textController.text);
      textController.clear();
      FocusManager.instance.primaryFocus.unfocus();
    }
  }

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
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: _searchUsers,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 15)
                      ),
                      onEditingComplete: _searchUsers,
                      validator: (value) {
                        return value == null || value == ''
                            ? 'Digite o nome que deseja buscar'
                            : null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
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
    return Center(child: Text(controller.status.props.first));
  }

  return ListView.builder(
    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    physics: BouncingScrollPhysics(),
    itemCount: controller.users.users.length,
    itemBuilder: (context, index) {
      return UserCard(
        user: controller.users.users[index],
      );
    },
  );
}
