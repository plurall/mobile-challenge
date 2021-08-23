import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class PhotoUser extends StatelessWidget {
  PhotoUser({@required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Image.network(
        url,
        filterQuality: FilterQuality.high,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => FlutterLogo(),
        loadingBuilder: (_, Widget child, ImageChunkEvent loadingProgress) {
          if (loadingProgress != null)
            return SkeletonAvatar(
              style: SkeletonAvatarStyle(),
            );
          return child;
        },
      ),
    );
  }
}
