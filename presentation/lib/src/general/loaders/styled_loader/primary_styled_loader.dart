part of 'styled_loader.dart';

final class _PrimaryStyledLoader extends StyledLoader {
  const _PrimaryStyledLoader({
    super.key,
    super.size,
    super.strokeWidth,
  });

  @override
  Color getColor(BuildContext context) => Theme.of(context).colorScheme.primary;
}
