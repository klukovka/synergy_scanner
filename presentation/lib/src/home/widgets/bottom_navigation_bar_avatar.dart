import 'package:flutter/material.dart';
import 'package:presentation/src/general/images/circle_icon_preview.dart';

class BottomNavigationBarAvatar extends StatelessWidget {
  final String? imageUrl;
  final bool isCurrent;

  const BottomNavigationBarAvatar({
    super.key,
    required this.imageUrl,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    final color = isCurrent
        ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
        : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor;

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color!, width: 2),
      ),
      child: CircleIconPreview.user(
        radius: 16,
        imageUrl: imageUrl,
        color: color,
      ),
    );
  }
}
