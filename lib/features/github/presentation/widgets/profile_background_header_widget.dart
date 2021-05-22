import 'package:flutter/material.dart';
import 'package:mobile_challenge/core/constants/app_dimensions.dart';

class ProfileBackgroundHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        width: _size.width,
        height: _size.height * 0.35,
        padding: EdgeInsets.only(left: AppDimensions.padding + 20),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Perfil',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}