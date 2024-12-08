import 'package:flutter/material.dart';
import 'package:localizations/localizations.dart';

extension BuildContextLocalizationsExtension on BuildContext {
  SynergyScannerLocalizations get strings =>
      SynergyScannerLocalizations.of(this);
}
