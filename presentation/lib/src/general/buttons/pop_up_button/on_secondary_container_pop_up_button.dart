part of 'pop_up_button.dart';

final class _OnSecondaryContainerPopUpButton extends PopUpButton {
  const _OnSecondaryContainerPopUpButton({
    super.key,
    required super.child,
    required super.onPressed,
  });

  @override
  TextStyle getTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          );
}
