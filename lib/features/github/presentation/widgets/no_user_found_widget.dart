import 'package:flutter/material.dart';
import 'package:mobile_challenge/core/constants/app_typography.dart';

class NoUserFoundWidget extends StatelessWidget {
  final String message;

  const NoUserFoundWidget({
    Key key,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: AppTypography.bodyText(context),
        textAlign: TextAlign.center,
      ),
    );
  }
}