import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Avatar extends StatelessWidget {
  final String? imageUrl;
  final Uint8List? imageBytes;

  final double radius;
  final Color? placeholderColor;
  final Color? backgroundColor;

  const Avatar({
    super.key,
    this.imageUrl,
    this.imageBytes,
    this.radius = 14,
    this.placeholderColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final ImageProvider<Object>? localImage =
        imageBytes != null ? MemoryImage(imageBytes!) : null;
    final ImageProvider<Object>? remoteImage =
        imageUrl != null ? NetworkImage(imageUrl!) : null;

    return CircleAvatar(
      foregroundImage: localImage ?? remoteImage,
      backgroundColor: backgroundColor ?? Colors.transparent,
      radius: radius,
      child: ((localImage ?? remoteImage) != null)
          ? null
          : Icon(
              MdiIcons.accountCircle,
              size: radius * 2,
              color: placeholderColor ?? Theme.of(context).colorScheme.primary,
            ),
    );
  }
}
