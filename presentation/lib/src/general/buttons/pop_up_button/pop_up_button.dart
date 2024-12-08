import 'package:flutter/material.dart';

part 'error_pop_up_button.dart';
part 'on_secondary_container_pop_up_button.dart';
part 'primary_pop_up_button.dart';

sealed class PopUpButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const PopUpButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  const factory PopUpButton.primary({
    Key? key,
    required Widget child,
    required VoidCallback onPressed,
  }) = _PrimaryPopUpButton;

  const factory PopUpButton.onSecondaryContainer({
    Key? key,
    required Widget child,
    required VoidCallback onPressed,
  }) = _OnSecondaryContainerPopUpButton;

  const factory PopUpButton.error({
    Key? key,
    required Widget child,
    required VoidCallback onPressed,
  }) = ErrorPopUpButton;

  TextStyle getTextStyle(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.hovered)) {
            return Theme.of(context)
                .colorScheme
                .onSecondaryContainer
                .withOpacity(0.04);
          }
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.focused)) {
            return Theme.of(context)
                .colorScheme
                .onSecondaryContainer
                .withOpacity(0.04);
          }

          return null;
        },
      ),
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: getTextStyle(context),
          child: child,
        ),
      ),
    );
  }
}
