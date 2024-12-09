import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:presentation/src/general/images/circle_memory_image.dart';
import 'package:presentation/src/general/images/circle_network_image.dart';

class CircleIconPreview extends StatelessWidget {
  final Widget Function(BuildContext context) placeholder;
  final Color Function(BuildContext context)? backgroundColor;
  final String? imageUrl;
  final Uint8List? imageBytes;
  final double radius;

  const CircleIconPreview({
    super.key,
    required this.placeholder,
    this.imageUrl,
    required this.radius,
    this.backgroundColor,
    this.imageBytes,
  });

  factory CircleIconPreview.user({
    Key? key,
    String? imageUrl,
    double radius = 24,
    Color? color,
  }) =>
      CircleIconPreview(
        key: key,
        imageUrl: imageUrl,
        placeholder: (context) => Icon(
          MdiIcons.accountCircle,
          size: radius * 2,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        radius: radius,
        backgroundColor: (context) =>
            color ?? Theme.of(context).colorScheme.primary,
      );

  @override
  Widget build(BuildContext context) {
    if (imageBytes != null) {
      return CircleMemoryImage(
        placeholder: placeholder(context),
        radius: radius,
        imageBytes: imageBytes,
        backgroundColor: backgroundColor?.call(context),
      );
    }
    return CircleNetworkImage(
      placeholder: placeholder(context),
      radius: radius,
      imageUrl: imageUrl,
      backgroundColor: backgroundColor?.call(context),
    );
  }
}
