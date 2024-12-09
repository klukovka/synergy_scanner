part of 'styled_loader.dart';

final class _CustomStyledLoader extends StyledLoader {
  final Color color;
  final Color backgroundColor;

  const _CustomStyledLoader({
    super.key,
    super.size,
    super.strokeWidth,
    required this.color,
    required this.backgroundColor,
  });

  @override
  Color getColor(BuildContext context) => color;
}
