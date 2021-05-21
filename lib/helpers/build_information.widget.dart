import 'package:flutter/material.dart';

class BuildInformation extends StatelessWidget {
  const BuildInformation({
    this.title,
    this.information,
    this.fontSizeTitle = 19,
    this.fontSizeInformation = 17,
  });
  final String title;
  final String information;
  final double fontSizeTitle;
  final double fontSizeInformation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: title + ': ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSizeTitle,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: information,
                style: TextStyle(
                    color: Colors.black, fontSize: fontSizeInformation),
              )
            ],
          ),
        ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }
}
