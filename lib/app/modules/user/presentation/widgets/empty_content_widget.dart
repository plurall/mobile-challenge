import 'package:flutter/material.dart';
import 'package:mobile_challenge/app/shared/utils/app_colors.dart';

class EmptyContentWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text("There's nothing here yet",
          style: TextStyle(
            color: AppColors.secondaryTextColor,
            fontWeight: FontWeight.w300,
            fontSize: 14
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}