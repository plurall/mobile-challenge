import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_challenge/core/constants/app_typography.dart';
import 'package:mobile_challenge/features/github/domain/entities/user_entity.dart';
import 'package:mobile_challenge/features/github/presentation/pages/user_profile_page.dart';

import 'error_image_widget.dart';

class UserCard extends StatelessWidget {
  final UserEntity user;
  final Function callback;

  const UserCard({
    Key key,
    @required this.user,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageRadius = 30.0;

    return GestureDetector(
      onTap: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => UserProfilePage(username: user.login)));
        if (callback != null) callback();
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(imageRadius),
                child: CachedNetworkImage(
                  imageUrl: user.avatarUrl,
                  height: 2 * imageRadius,
                  width: 2 * imageRadius,
                  placeholder: (_, __) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (_, __, ___) =>
                      ErrorImageWidget(imageRadius: imageRadius),
                  fadeOutDuration: Duration(seconds: 0),
                ),
              ),
              SizedBox(width: 20),
              Text(
                user.login,
                style: AppTypography.bodyText(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
