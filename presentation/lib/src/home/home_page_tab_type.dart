import 'package:domain/domain.dart';
import 'package:flutter/widgets.dart';
import 'package:localizations/localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum HomePageTabType {
  partners(route: Destination.partners),
  criterias(route: Destination.criterias),
  analytics(route: Destination.analytics),
  profile(route: Destination.profile);

  final Destination route;

  const HomePageTabType({
    required this.route,
  });

  IconData get inactiveIconData => switch (this) {
        HomePageTabType.criterias => MdiIcons.accountSupervisorOutline,
        HomePageTabType.analytics => MdiIcons.scatterPlotOutline,
        HomePageTabType.profile => MdiIcons.accountCircleOutline,
        HomePageTabType.partners => MdiIcons.heartMultipleOutline,
      };

  IconData get activeIconData => switch (this) {
        HomePageTabType.criterias => MdiIcons.accountSupervisor,
        HomePageTabType.analytics => MdiIcons.scatterPlot,
        HomePageTabType.profile => MdiIcons.accountCircle,
        HomePageTabType.partners => MdiIcons.heartMultiple,
      };

  String getDisplayText(BuildContext context) => switch (this) {
        HomePageTabType.criterias => context.strings.criterias,
        HomePageTabType.analytics => context.strings.analytics,
        HomePageTabType.profile => context.strings.profile,
        HomePageTabType.partners => context.strings.partners,
      };
}
