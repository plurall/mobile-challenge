import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/utils/app_colors.dart';
import '../../domain/entities/user_detail_entity.dart';

class UserTile extends StatelessWidget {
  final UserDetailEntity user;
  const UserTile(this.user);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Modular.to.pushNamed("/profile/${user.login}"),
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        padding: const EdgeInsets.all(12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          border: Border.all(color: AppColors.borderColor, width: 1),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: CachedNetworkImage(
                imageUrl: user.avatarUrl,
                height: 56,
                width: 56,
              ),
            ),
            SizedBox(width: 12),
            Text(user.login,
              style: TextStyle(
                color: AppColors.primaryTextColor,
                fontWeight: FontWeight.w400
              ),
            )
          ],
        ),
      ),
    );
  }
}