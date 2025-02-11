import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:presentation/src/general/buttons/selector_button.dart';
import 'package:presentation/src/utilts/extensions/button_style_extension.dart';

class MoreSelectorButton extends StatefulWidget {
  final List<Widget> Function(BuildContext context) children;
  final Widget? icon;

  const MoreSelectorButton({
    super.key,
    required this.children,
    this.icon,
  });

  @override
  State<MoreSelectorButton> createState() => _MoreSelectorButtonState();
}

class _MoreSelectorButtonState extends State<MoreSelectorButton> {
  late final WidgetStatesController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WidgetStatesController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateController(bool addFocus) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.update(WidgetState.focused, addFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SelectorButton(
      statesController: _controller,
      picker: Builder(
        builder: (context) => SizedBox(
          width: 260,
          child: Material(
            color: Theme.of(context).colorScheme.surface,
            elevation: 12,
            shadowColor: Theme.of(context)
                .colorScheme
                .onSecondaryContainer
                .withOpacity(0.34),
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.children(context).insertSeparator(
                    () => Divider(
                      height: 1,
                      thickness: 1,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
            ),
          ),
        ),
      ),
      onPickerOpened: () => _updateController(true),
      onPickerClose: () => _updateController(false),
      style: ButtonStyle(
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        fixedSize: const WidgetStatePropertyAll(Size(36, 36)),
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.any((state) =>
              state == WidgetState.pressed ||
              state == WidgetState.hovered ||
              state == WidgetState.focused)) {
            return Theme.of(context).colorScheme.primary;
          }
          return Theme.of(context).colorScheme.onSecondaryContainer;
        }),
      ).applyForegroundToIcon(),
      builder: (controller) =>
          widget.icon ?? Icon(MdiIcons.dotsHorizontal, size: 24),
      pickerAnchor: (offset) => Alignment.topRight,
      buttonAnchor: Alignment.bottomRight,
    );
  }
}
