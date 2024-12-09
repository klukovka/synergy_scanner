import 'package:flutter/material.dart';

part 'custom_styled_loader.dart';
part 'on_primary_styled_loader.dart';
part 'on_secondary_container_styled_loader.dart';
part 'primary_styled_loader.dart';
part 'tertiary_styled_loader.dart';

sealed class StyledLoader extends StatelessWidget {
  final double size;
  final double strokeWidth;

  const StyledLoader({
    super.key,
    this.size = 20,
    this.strokeWidth = 2.5,
  });

  const factory StyledLoader.custom({
    Key? key,
    double size,
    double strokeWidth,
    required Color color,
    required Color backgroundColor,
  }) = _CustomStyledLoader;

  const factory StyledLoader.primary({
    Key? key,
    double size,
    double strokeWidth,
  }) = _PrimaryStyledLoader;

  const factory StyledLoader.onPrimary({
    Key? key,
  }) = _OnPrimaryStyledLoader;

  const factory StyledLoader.tertiary({
    Key? key,
  }) = _TertiaryStyledLoader;

  const factory StyledLoader.onSecondaryContainer({
    Key? key,
  }) = _OnSecondaryContainerStyledLoader;

  Color getColor(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: RepaintBoundary(
        key: const ValueKey('progressindicator'),
        child: CircularProgressIndicator(
          color: getColor(context),
          strokeWidth: strokeWidth,
          backgroundColor: getColor(context).withOpacity(0.5),
        ),
      ),
    );
  }
}
