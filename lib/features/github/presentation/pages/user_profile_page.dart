import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_challenge/features/github/presentation/stores/user_profile_store.dart';
import 'package:mobile_challenge/features/github/presentation/widgets/back_button_widget.dart';
import 'package:mobile_challenge/features/github/presentation/widgets/error_text_widget.dart';
import 'package:mobile_challenge/features/github/presentation/widgets/profile_background_header_widget.dart';
import 'package:mobile_challenge/features/github/presentation/widgets/profile_card_widget.dart';
import 'package:mobile_challenge/features/github/presentation/widgets/profile_avatar_widget.dart';
import 'package:mobile_challenge/features/github/presentation/widgets/user_info_widget.dart';

import '../../../../injection_container.dart';

class UserProfilePage extends StatefulWidget {
  final String username;

  const UserProfilePage({Key key, @required this.username}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final controller = sl<UserProfileStore>();

  @override
  void initState() {
    super.initState();
    controller.getUserInfo(widget.username);
    controller.checkIfUserIsSaved(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          ProfileBackgroundHeaderWidget(),
          BackButtonWidget(),
          ProfileCardWidget(
            content: Observer(
              builder: (context) =>
                  _getWidgetBasedOnStatus(context, controller),
            ),
          ),
          Observer(builder: (_) {
            return ProfileAvatarWidget(
              imageUrl: controller.userEntity?.avatarUrl ?? null,
            );
          }),
        ],
      ),
    );
  }
}

Widget _getWidgetBasedOnStatus(
    BuildContext context, UserProfileStore controller) {
  if (controller.userStatus is Idle) {
    return SizedBox();
  } else if (controller.userStatus is Loading) {
    return Center(child: CircularProgressIndicator());
  } else if (controller.userStatus is Error) {
    return ErrorTextWidget(message: controller.userStatus.props.first);
  }

  return UserInfoWidget(
    controller: controller,
  );
}
