import 'package:flutter/material.dart';

import '../../features/github_user/presentation/widgets/text_widget.dart';
import '../theme/app_colors.dart';

class GithubUserCardWidget extends StatelessWidget {
  final String name;
  final String email;
  final String location;
  final String bio;
  final String avatar_url;
  final VoidCallback onTapIcon;

  const GithubUserCardWidget({
    Key key,
    @required this.name,
    @required this.email,
    @required this.location,
    @required this.bio,
    @required this.avatar_url,
    @required this.onTapIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primary,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(avatar_url),
        ),
        title: Row(
          children: [
            TextWidget(
              text: name,
            ),
            TextWidget(
              text: email,
            ),
          ],
        ),
        subtitle: Column(
          children: [
            Row(
              children: [
                TextWidget(
                  text: email,
                ),
                Expanded(
                  child: TextWidget(
                    text: location,
                  ),
                ),
              ],
            ),
            Divider(
              color: AppColors.background,
            ),
            Row(
              children: [
                Expanded(
                  child: TextWidget(
                    text: bio,
                  ),
                ),
              ],
            )
          ],
        ),
        isThreeLine: true,
        trailing: IconButton(
          onPressed: onTapIcon,
          icon: Icon(
            Icons.star_outline,
            color: AppColors.text_primary,
          ),
        ),
      ),
    );
  }
}
