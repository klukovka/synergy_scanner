part of 'styled_loader.dart';

final class _TertiaryStyledLoader extends StyledLoader {
  const _TertiaryStyledLoader({super.key});

  @override
  Color getColor(BuildContext context) =>
      (Theme.of(context).colorScheme.tertiary as MaterialColor)[600]!;
}
