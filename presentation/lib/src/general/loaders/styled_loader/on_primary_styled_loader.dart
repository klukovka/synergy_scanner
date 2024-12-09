part of 'styled_loader.dart';

final class _OnPrimaryStyledLoader extends StyledLoader {
  const _OnPrimaryStyledLoader({super.key});

  @override
  Color getColor(BuildContext context) =>
      Theme.of(context).colorScheme.onPrimary;
}
