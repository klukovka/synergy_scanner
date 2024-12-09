import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:localizations/localizations.dart';

extension PartnerTypeExtension on PartnerType {
  String getDisplayText(BuildContext context) => switch (this) {
        PartnerType.ex => context.strings.ex,
        PartnerType.friend => context.strings.friend,
        PartnerType.crush => context.strings.crush,
        PartnerType.situationship => context.strings.situationship,
        PartnerType.current => context.strings.current,
      };
}
