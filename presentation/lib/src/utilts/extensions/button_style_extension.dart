import 'package:flutter/material.dart';

extension ButtonStyleExtension on ButtonStyle {
  ButtonStyle applyForegroundToIcon() => copyWith(
        iconColor: iconColor == null ? foregroundColor : null,
      );
}
