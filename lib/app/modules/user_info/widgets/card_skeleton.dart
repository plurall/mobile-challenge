import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class LoaderSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: SkeletonAvatar(style: SkeletonAvatarStyle())),
        SizedBox(height: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                SkeletonParagraph(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
