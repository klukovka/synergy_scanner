import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/src/utilts/extensions/button_style_extension.dart';

enum MenuItemIconPosition {
  left,
  right;
}

class MenuItem extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final MenuItemIconPosition iconPosition;

  const MenuItem({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.style,
    this.iconPosition = MenuItemIconPosition.left,
  });

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: const IconThemeData(size: 24),
      child: TextButton(
        onPressed: onPressed,
        style: (style ?? const ButtonStyle())
            .merge(
              ButtonStyle(
                padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
                foregroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                textStyle: WidgetStatePropertyAll(
                  Theme.of(context).textTheme.titleSmall,
                ),
                shape: const WidgetStatePropertyAll(
                  RoundedRectangleBorder(),
                ),
              ),
            )
            .applyForegroundToIcon(),
        child: switch (iconPosition) {
          MenuItemIconPosition.right => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, textAlign: TextAlign.left),
                icon,
              ].insertSeparator(() => const SizedBox(width: 20)),
            ),
          MenuItemIconPosition.left => Row(
              children: [
                icon,
                Text(label, textAlign: TextAlign.left),
              ].insertSeparator(() => const SizedBox(width: 20)),
            ),
        },
      ),
    );
  }
}
