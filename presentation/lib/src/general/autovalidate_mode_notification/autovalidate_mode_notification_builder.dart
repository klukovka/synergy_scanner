import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/src/general/autovalidate_mode_notification/autovalidate_mode_notification.dart';

class AutovalidateModeNotificationBuilder extends StatefulWidget {
  final Widget Function(
    BuildContext context,
    AutovalidateMode autovalidateMode,
    Widget? child,
  ) builder;
  final Widget? child;

  const AutovalidateModeNotificationBuilder({
    super.key,
    required this.builder,
    this.child,
  });

  @override
  State<AutovalidateModeNotificationBuilder> createState() =>
      _AutovalidateModeNotificationBuilderState();

  static ValueNotifier<AutovalidateMode> of(BuildContext context) => context
      .findAncestorStateOfType<_AutovalidateModeNotificationBuilderState>()!
      ._autovalidateModeNotifier;
}

class _AutovalidateModeNotificationBuilderState
    extends State<AutovalidateModeNotificationBuilder> {
  late final ValueNotifier<AutovalidateMode> _autovalidateModeNotifier;

  @override
  void initState() {
    super.initState();
    _autovalidateModeNotifier = ValueNotifier(
      AutovalidateMode.disabled,
    );
  }

  @override
  void dispose() {
    _autovalidateModeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<AutovalidateModeNotification>(
      onNotification: (notification) {
        final value = notification.autovalidateMode;
        if (_autovalidateModeNotifier.value != value) {
          _autovalidateModeNotifier.value = value;
        }
        return true;
      },
      child: ValueListenableBuilder(
        valueListenable: _autovalidateModeNotifier,
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
