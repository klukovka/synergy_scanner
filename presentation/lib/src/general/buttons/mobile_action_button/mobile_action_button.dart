import 'package:flutter/material.dart';

part 'primary_mobile_action_button.dart';
part 'surface_variant_mobile_action_button.dart';
part 'two_lines_mobile_action_button.dart';

sealed class MobileActionButton extends StatefulWidget {
  final Widget title;
  final Widget? subtitle;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;

  const MobileActionButton({
    super.key,
    required this.title,
    this.subtitle,
    this.textStyle,
    this.onPressed,
  });

  const factory MobileActionButton.surfaceContainerHighest({
    Key? key,
    required Widget title,
    VoidCallback? onPressed,
  }) = _SurfaceVariantMobileActionButton;

  const factory MobileActionButton.primary({
    Key? key,
    required Widget title,
    VoidCallback? onPressed,
    TextStyle? textStyle,
  }) = _PrimaryMobileActionButton;

  const factory MobileActionButton.twoLines({
    Key? key,
    required Widget title,
    Widget? subtitle,
    VoidCallback? onPressed,
  }) = _TwoLinesMobileActionButton;
}

sealed class MobileActionButtonState extends State<MobileActionButton> {
  late final WidgetStatesController statesController;

  @override
  void initState() {
    super.initState();
    statesController = WidgetStatesController();
  }

  @override
  void dispose() {
    statesController.dispose();
    super.dispose();
  }

  WidgetStateProperty<Color?> getForegroundColor(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final foregroundColor = getForegroundColor(context);
    return TextButton(
      statesController: statesController,
      style: ButtonStyle(
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        foregroundColor: foregroundColor,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: WidgetStatePropertyAll(
          widget.textStyle ?? Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      onPressed: widget.onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.title,
          Offstage(
            offstage: widget.subtitle == null,
            child: ValueListenableBuilder(
              valueListenable: statesController,
              builder: (context, value, child) => DefaultTextStyle(
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: foregroundColor.resolve(value),
                    ),
                child: child!,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: widget.subtitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
