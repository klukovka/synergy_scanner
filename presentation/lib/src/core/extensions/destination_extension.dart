import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localizations/localizations.dart';
import 'package:redux/redux.dart';

extension DestinationExtension on Destination {
  String getDestinationLabel(BuildContext context) => getStoredLabel(
        StoreProvider.of<AppState>(context, listen: false),
        context.strings,
      );

  String getStoredLabel(
    Store<AppState> store,
    SynergyScannerLocalizations strings,
  ) {
    final state = store.state;

    return switch (this) {
      Destination.login => strings.login,
      Destination.signUp => strings.signUp,
      Destination.unexpectedError => strings.unexpectedError,
      Destination.partners => strings.partners,
      Destination.criterias => strings.criterias,
      Destination.analytics => strings.analytics,
      Destination.profile => strings.profile,
      Destination.createPartner => strings.createPartner,
    };
  }
}
