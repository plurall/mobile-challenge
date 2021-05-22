import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_challenge/core/constants/app_dimensions.dart';
import 'package:mobile_challenge/features/github/presentation/stores/users_store.dart';
import 'package:mobile_challenge/features/github/presentation/widgets/error_text_widget.dart';
import 'package:mobile_challenge/features/github/presentation/widgets/github_users_list_widget.dart';
import 'package:mobile_challenge/features/github/presentation/widgets/no_user_found_widget.dart';
import 'package:mobile_challenge/features/github/presentation/widgets/page_title_widget.dart';

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
        padding: const EdgeInsets.only(
          top: AppDimensions.paddingTop,
          left: AppDimensions.horizontalPadding,
          right: AppDimensions.horizontalPadding,
        ),
        child: Column(
          children: [
            PageTitle(title: 'Busque por um perfil'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: formKey,
                child: TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                      hintText: 'Nome',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: _searchUsers,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 15)),
                  onEditingComplete: _searchUsers,
                  validator: (value) {
                    return value == null || value == ''
                        ? 'Digite o nome que deseja buscar'
                        : null;
                  },
                ),
              ),
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
    return ErrorTextWidget(message: controller.status.props.first);
  }

  return controller.users.users.isEmpty
      ? NoUserFoundWidget(
          message: 'Nenhum usuário encontrado com o nome informado')
      : GithubUsersListWidget(usersEntity: controller.users);
}
