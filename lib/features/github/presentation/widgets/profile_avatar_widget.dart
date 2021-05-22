import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_challenge/features/github/presentation/widgets/error_image_widget.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final String imageUrl;

  const ProfileAvatarWidget({
    Key key,
    @required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    final imageRadius = 60.0;

    return Positioned(
      top: _size.height * 0.28 - imageRadius,
      child: imageUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(imageRadius),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 2 * imageRadius,
                width: 2 * imageRadius,
                placeholder: (_, __) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (_, __, ___) =>
                    ErrorImageWidget(imageRadius: imageRadius),
              ),
            )
          : ErrorImageWidget(
              imageRadius: imageRadius,
              iconSize: 40,
            ),
    );
  }
}
