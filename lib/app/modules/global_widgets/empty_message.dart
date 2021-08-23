import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyMessage extends StatelessWidget {
  EmptyMessage({@required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DottedBorder(
        radius: const Radius.circular(8),
        color: Colors.grey,
        borderType: BorderType.RRect,
        dashPattern: [8, 4],
        child: SizedBox(
          width: double.infinity,
          height: 100,
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Get.textTheme.subtitle1.apply(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
