import 'package:flutter/material.dart';
import 'package:mobile_challenge/utils/palette.dart';

class MessageWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  MessageWidget({@required this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(color: Palette.darkWhiteText),
          ),
          icon == null
              ? SizedBox()
              : Icon(
                  icon,
                  color: Palette.darkWhiteText,
                ),
        ],
      ),
    );
  }
}
