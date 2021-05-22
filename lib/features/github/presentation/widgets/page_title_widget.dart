import 'package:flutter/material.dart';
import 'package:mobile_challenge/core/constants/app_typography.dart';

class PageTitle extends StatelessWidget {
  final String title;

  const PageTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.pageTitle(context),
        ),
        Divider(
          color: Colors.black,
        ),
      ],
    );
  }
}