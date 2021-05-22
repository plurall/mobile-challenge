import 'package:flutter/material.dart';
import 'package:mobile_challenge/core/constants/app_dimensions.dart';

class BackButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double paddingTop = MediaQuery.of(context).padding.top;
    return Positioned(
      top: paddingTop + 20,
      left: AppDimensions.padding,
      child: GestureDetector(
        onTap: Navigator.of(context).pop,
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }
}