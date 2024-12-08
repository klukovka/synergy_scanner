import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomNetworkImage extends StatelessWidget {
  final BorderRadius borderRadius;
  final String imageUrl;
  final double? height;
  final double? width;

  const CustomNetworkImage({
    super.key,
    this.borderRadius = BorderRadius.zero,
    required this.imageUrl,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        width: width,
        height: height,
        progressIndicatorBuilder: (context, url, progress) => Center(
          child: SpinKitThreeBounce(
            color: Theme.of(context).colorScheme.primary,
            size: 16,
          ),
        ),
      ),
    );
  }
}
