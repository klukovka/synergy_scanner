import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class IconCircleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData _iconData;

  const IconCircleButton.arrowBack({
    super.key,
    required this.onPressed,
  }) : _iconData = Icons.arrow_back_ios_rounded;

  const IconCircleButton.arrowForward({
    super.key,
    required this.onPressed,
  }) : _iconData = Icons.arrow_forward_ios_rounded;

  const IconCircleButton.add({
    super.key,
    required this.onPressed,
  }) : _iconData = Icons.add;

  IconCircleButton.substract({
    super.key,
    required this.onPressed,
  }) : _iconData = MdiIcons.minus;

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: onPressed,
      icon: Icon(_iconData),
      constraints: const BoxConstraints.tightFor(width: 48, height: 48),
      iconSize: 28,
      padding: EdgeInsets.zero,
    );
  }
}
