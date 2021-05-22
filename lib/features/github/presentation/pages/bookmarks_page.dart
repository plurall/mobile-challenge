import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_challenge/features/github/presentation/stores/bookmarks_store.dart';
import 'package:mobile_challenge/features/github/presentation/widgets/github_users_list_widget.dart';
import 'package:mobile_challenge/features/github/presentation/widgets/no_user_found_widget.dart';
import 'package:mobile_challenge/features/github/presentation/widgets/page_title_widget.dart';
import 'package:mobile_challenge/features/github/presentation/widgets/user_card_widget.dart';
import 'package:mobile_challenge/injection_container.dart';

class BookmarksPage extends StatefulWidget {
  @override
  _BookmarksPageState createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  final controller = sl<BookmarksStore>();

  @override
  void initState() {
    super.initState();
    controller.getBookmarkedUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
          left: 24,
          right: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageTitle(title: 'Perfis salvos'),
            Expanded(
              child: Observer(
                builder: (context) =>
                    _getWidgetBasedOnStatus(context, controller),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _getWidgetBasedOnStatus(
    BuildContext context, BookmarksStore controller) {
  if (controller.bookmarksStatus is Idle) {
    return SizedBox();
  } else if (controller.bookmarksStatus is Loading) {
    return Center(child: CircularProgressIndicator());
  } else if (controller.bookmarksStatus is Error) {
    return Text(controller.bookmarksStatus.props.first);
  }

  return controller.usersEntity.users.isEmpty
      ? NoUserFoundWidget(
          message:
              'Nenhum usuário salvo, continue navegando e adicione os usuários aos seus favoritos para que possa acessá-los mesmo quando não tiver conexão com a internet.',
        )
      : GithubUsersListWidget(
          usersEntity: controller.usersEntity,
          callback: controller.getBookmarkedUsers,
        );
}
