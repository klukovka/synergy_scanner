import 'package:flutter/material.dart';
import 'package:localizations/localizations.dart';

extension BuildContextLocalizationsExtension on BuildContext {
  CampguruLocalizations get strings => CampguruLocalizations.of(this);
}
