import 'dart:math';

import 'package:flutter/material.dart';
import 'package:presentation/src/general/buttons/action_button.dart';
import 'package:presentation/src/general/pickers/popup_picker.dart';

class SelectorButtonController {
  final Animation<double> animation;
  final VoidCallback openPicker;
  final VoidCallback closePicker;

  SelectorButtonController({
    required this.animation,
    required this.openPicker,
    required this.closePicker,
  });
}

class SelectorButton extends StatefulWidget {
  final Alignment Function(Offset offset) pickerAnchor;
  final Alignment buttonAnchor;
  final Offset pickerOffset;
  final Widget picker;
  final ButtonStyle? style;
  final Widget Function(SelectorButtonController controller) builder;
  final VoidCallback? onPickerOpened;
  final VoidCallback? onPickerClose;
  final bool hasRotationAnimation;
  final String? errorText;
  final WidgetStatesController? statesController;
  final bool enabled;
  final FocusNode? focusNode;

  const SelectorButton({
    super.key,
    required this.picker,
    required this.builder,
    required this.pickerAnchor,
    required this.buttonAnchor,
    this.style,
    this.onPickerOpened,
    this.onPickerClose,
    this.pickerOffset = Offset.zero,
    this.hasRotationAnimation = false,
    this.errorText,
    this.statesController,
    this.enabled = true,
    this.focusNode,
  });

  @override
  State<SelectorButton> createState() => _SelectorButtonState();
}

class PickerChangedNotifier extends ChangeNotifier {
  void rebuild() =>
      WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
}

class _SelectorButtonState extends State<SelectorButton>
    with SingleTickerProviderStateMixin {
  static const _animationDuration = Duration(milliseconds: 200);

  final link = LayerLink();

  late final OverlayEntry picker;
  late final OverlayEntry barrier;
  late final AnimationController _animationController;
  final GlobalKey _key = GlobalKey();

  final _pickerNotifier = PickerChangedNotifier();

  @override
  void didUpdateWidget(covariant SelectorButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.picker != widget.picker) {
      _pickerNotifier.rebuild();
    }
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );

    picker = OverlayEntry(
      builder: (context) {
        final buttonGlobalPosition =
            (_key.currentContext?.findRenderObject() as RenderBox?)
                ?.localToGlobal(Offset.zero);

        final followerAnchor =
            widget.pickerAnchor(buttonGlobalPosition ?? Offset.zero);
        final topAspect = (followerAnchor.y + 1) / 2;
        final bottomAspect = 1 - topAspect;
        final startLine = ((buttonGlobalPosition?.dy ?? 0) +
            ((widget.buttonAnchor.y + 1) / 2) * (link.leaderSize?.height ?? 0));
        final topMaxHeight = startLine / topAspect;
        final bottomMaxHeight =
            (MediaQuery.of(context).size.height - startLine) / bottomAspect;
        return Positioned(
          top: 0,
          child: CompositedTransformFollower(
            showWhenUnlinked: false,
            offset: widget.pickerOffset,
            followerAnchor: followerAnchor,
            targetAnchor: widget.buttonAnchor,
            link: link,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: min(topMaxHeight, bottomMaxHeight),
              ),
              child: PopupPicker(
                close: _close,
                leaderSize: link.leaderSize ?? Size.zero,
                child: ListenableBuilder(
                  listenable: _pickerNotifier,
                  builder: (context, _) => widget.picker,
                ),
              ),
            ),
          ),
        );
      },
    );
    barrier = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _close,
        ),
      ),
    );
    picker.addListener(
      widget.hasRotationAnimation
          ? _onPickerStateChangedWithAnimation
          : _onPickerStateChanged,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    if (picker.mounted) {
      picker.remove();
    }
    if (barrier.mounted) {
      barrier.remove();
    }
    super.dispose();
  }

  void _close() {
    picker.remove();
    barrier.remove();
  }

  void _open() {
    Overlay.of(context).insertAll([barrier, picker]);
    widget.onPickerOpened?.call();
  }

  void _onPickerStateChangedWithAnimation() {
    if (picker.mounted) {
      _animationController.forward();
    } else {
      _animationController.reverse();
      widget.onPickerClose?.call();
    }
  }

  void _onPickerStateChanged() {
    if (!picker.mounted) {
      widget.onPickerClose?.call();
    }
  }

  void _onSelectorPressed() {
    if (picker.mounted) {
      _close();
    } else {
      _open();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      key: _key,
      link: link,
      child: ActionButton(
        style: widget.style,
        statesController: widget.statesController,
        onPressed: widget.enabled ? _onSelectorPressed : null,
        focusNode: widget.focusNode,
        child: widget.builder(
          SelectorButtonController(
            animation: _animationController,
            openPicker: _open,
            closePicker: _close,
          ),
        ),
      ),
    );
  }
}
