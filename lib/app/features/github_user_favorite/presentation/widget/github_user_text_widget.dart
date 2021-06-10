import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class GithubTextWidget extends StatelessWidget {
  final String text;
  const GithubTextWidget({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        text ?? '',
        style: TextStyle(
          color: AppColors.text_primary,
        ),
      ),
    );
  }
}
