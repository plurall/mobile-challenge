import 'package:flutter/material.dart';

class ErrorImageWidget extends StatelessWidget {
  final double iconSize;
  const ErrorImageWidget({
    Key key,
    @required this.imageRadius,
    this.iconSize = 24,
  }) : super(key: key);

  final double imageRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2 * imageRadius,
      width: 2 * imageRadius,
      decoration: BoxDecoration(
        color: Colors.grey[600],
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.broken_image_rounded,
        color: Colors.grey[200],
        size: iconSize,
      ),
    );
  }
}
