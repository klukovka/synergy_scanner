part of 'mobile_action_button.dart';

final class _SurfaceVariantMobileActionButton extends MobileActionButton {
  const _SurfaceVariantMobileActionButton({
    super.key,
    required super.title,
    super.onPressed,
  });

  @override
  MobileActionButtonState createState() =>
      _SurfaceVariantMobileActionButtonState();
}

final class _SurfaceVariantMobileActionButtonState
    extends MobileActionButtonState {
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
