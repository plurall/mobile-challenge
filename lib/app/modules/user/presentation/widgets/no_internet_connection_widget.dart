import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../shared/utils/app_colors.dart';

class NoInternetConnectionWidget extends StatelessWidget {
  const NoInternetConnectionWidget({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off_outlined, size: 100),
          SizedBox(height: 24),
          Text("Looks like you're offline :/",
            style: TextStyle(
              color: AppColors.primaryTextColor,
              fontSize: 22,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 12),
          Text("Make sure you have internet connection to access this feature",
            style: TextStyle(
              color: AppColors.secondaryTextColor,
              fontSize: 14,
              fontWeight: FontWeight.w300
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}