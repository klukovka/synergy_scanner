part of 'styled_loader.dart';

final class _OnSecondaryContainerStyledLoader extends StyledLoader {
  const _OnSecondaryContainerStyledLoader({super.key});

  @override
  Color getColor(BuildContext context) =>
      Theme.of(context).colorScheme.onSecondaryContainer;
}
