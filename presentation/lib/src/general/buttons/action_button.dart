import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final ButtonStyle? style;
  final WidgetStatesController? statesController;
  final VoidCallback? onPressed;
  final Widget child;
  final FocusNode? focusNode;

  const ActionButton({
    super.key,
    this.style,
    this.statesController,
    this.onPressed,
    required this.child,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      focusNode: focusNode,
      style: (style ?? const ButtonStyle()).merge(
        ButtonStyle(
          visualDensity: const VisualDensity(),
          overlayColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.hovered)) {
                return Theme.of(context)
                    .colorScheme
                    .onSecondaryContainer
                    .withOpacity(0.04);
              }

              if (states.contains(WidgetState.focused) ||
                  states.contains(WidgetState.pressed)) {
                return Theme.of(context)
                    .colorScheme
                    .onSecondaryContainer
                    .withOpacity(0.04);
              }

              return null;
            },
          ),
        ),
      ),
      statesController: statesController,
      onPressed: onPressed,
      child: child,
    );
  }
}
