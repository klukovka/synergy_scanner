part of 'mobile_action_button.dart';

final class _TwoLinesMobileActionButton extends MobileActionButton {
  const _TwoLinesMobileActionButton({
    super.key,
    required super.title,
    super.onPressed,
    super.subtitle,
  });

  @override
  MobileActionButtonState createState() => _TwoLinesMobileActionButtonState();
}

final class _TwoLinesMobileActionButtonState extends MobileActionButtonState {
  @override
  WidgetStateProperty<Color?> getForegroundColor(BuildContext context) =>
      WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.disabled)) {
            return Theme.of(context).colorScheme.onSurfaceVariant;
          }
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.pressed)) {
            return Theme.of(context).colorScheme.onSecondaryContainer;
          }
          return Theme.of(context).colorScheme.surfaceContainerHighest;
        },
      );
}
