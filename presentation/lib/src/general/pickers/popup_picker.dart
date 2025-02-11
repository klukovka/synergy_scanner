import 'package:flutter/material.dart';

class PopupPicker extends InheritedWidget {
  final VoidCallback close;
  final Size leaderSize;

  const PopupPicker({
    super.key,
    required this.close,
    required super.child,
    required this.leaderSize,
  });

  static PopupPicker of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<PopupPicker>()!;

  static PopupPicker? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<PopupPicker>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
