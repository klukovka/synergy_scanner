part of 'mobile_action_button.dart';

final class _PrimaryMobileActionButton extends MobileActionButton {
  const _PrimaryMobileActionButton({
    super.key,
    required super.title,
    super.onPressed,
    super.textStyle,
  });

  @override
  MobileActionButtonState createState() => _PrimaryMobileActionButtonState();
}

final class _PrimaryMobileActionButtonState extends MobileActionButtonState {
  @override
  WidgetStateProperty<Color?> getForegroundColor(BuildContext context) =>
      WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.disabled)) {
            return Theme.of(context).colorScheme.onSurfaceVariant;
          }
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.pressed)) {
            return Color.alphaBlend(
              Theme.of(context)
                  .colorScheme
                  .onSecondaryContainer
                  .withOpacity(0.24),
              Theme.of(context).colorScheme.primary,
            );
          }
          return Theme.of(context).colorScheme.primary;
        },
      );
}
