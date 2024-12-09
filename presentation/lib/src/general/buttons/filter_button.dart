import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FilterButton extends StatelessWidget {
  final bool isEmpty;
  final VoidCallback onPressed;

  const FilterButton({
    super.key,
    required this.isEmpty,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onPressed,
      icon: Icon(MdiIcons.filterOutline),
      selectedIcon: Icon(MdiIcons.filter),
      isSelected: !isEmpty,
      constraints: const BoxConstraints.tightFor(width: 48, height: 48),
      iconSize: 28,
      padding: EdgeInsets.zero,
    );
  }
}
