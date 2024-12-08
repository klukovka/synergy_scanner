import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
              Theme.of(context).extension<AvatarThemeData>()?.defaultIcon,
              size: radius * 2,
              color: placeholderColor ?? Theme.of(context).colorScheme.primary,
            ),
    );
  }
}

class AvatarThemeData extends ThemeExtension<AvatarThemeData> {
  final IconData defaultIcon;

  AvatarThemeData({
    required this.defaultIcon,
  });

  @override
  ThemeExtension<AvatarThemeData> copyWith({IconData? defaultIcon}) =>
      AvatarThemeData(defaultIcon: defaultIcon ?? this.defaultIcon);

  @override
  ThemeExtension<AvatarThemeData> lerp(
    ThemeExtension<AvatarThemeData>? other,
    double t,
  ) =>
      other ?? this;
}
