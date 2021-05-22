import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_challenge/core/constants/app_dimensions.dart';
import 'package:mobile_challenge/core/constants/app_failures_messages.dart';
import 'package:mobile_challenge/features/github/presentation/stores/bookmarks_store.dart';
import 'package:mobile_challenge/features/github/presentation/widgets/github_users_list_widget.dart';
import 'package:mobile_challenge/features/github/presentation/widgets/no_user_found_widget.dart';
import 'package:mobile_challenge/features/github/presentation/widgets/page_title_widget.dart';
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
          top: AppDimensions.paddingTop,
          left: AppDimensions.horizontalPadding,
          right: AppDimensions.horizontalPadding,
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
    return NoUserFoundWidget(
      message: controller.bookmarksStatus.props.first,
    );
  }

  return controller.usersEntity.users.isEmpty
      ? NoUserFoundWidget(
          message: AppFailureMessages.NO_USER_CACHED,
        )
      : GithubUsersListWidget(
          usersEntity: controller.usersEntity,
          callback: controller.getBookmarkedUsers,
        );
}
