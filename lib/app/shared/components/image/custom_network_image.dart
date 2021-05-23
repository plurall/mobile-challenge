import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    Key key,
    @required this.imageUrl,
    this.fit = BoxFit.contain,
    this.borderRadiusSkeleton = BorderRadius.zero,
  }) : super(key: key);

  final String imageUrl;
  final BoxFit fit;
  final BorderRadius borderRadiusSkeleton;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, _) => _skeleton(),
      imageUrl: imageUrl,
      fit: fit,
    );
  }

  Widget _skeleton() {
    return Container(
      color: Colors.grey[300],
      child: ClipRRect(
        borderRadius: borderRadiusSkeleton,
        child: Container(
          color: Colors.grey[300],
        ),
      ),
    );
  }
}
