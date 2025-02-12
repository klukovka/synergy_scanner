import 'package:domain/domain.dart';
import 'package:presentation/src/navigation/base_route.dart';
import 'package:presentation/src/navigation/parsing/routes/analytics_route.dart';
import 'package:presentation/src/navigation/parsing/routes/create_criteria_route.dart';
import 'package:presentation/src/navigation/parsing/routes/criterias_route.dart';
import 'package:presentation/src/navigation/parsing/routes/login_route.dart';
import 'package:presentation/src/navigation/parsing/routes/partners/create_partner_route.dart';
import 'package:presentation/src/navigation/parsing/routes/partners/edit_partner_route.dart';
import 'package:presentation/src/navigation/parsing/routes/partners/partner_details_route.dart';
import 'package:presentation/src/navigation/parsing/routes/partners/partners_route.dart';
import 'package:presentation/src/navigation/parsing/routes/profile_route.dart';

const routes = <BaseRoute<AppState>>[
  LoginRoute(),
  PartnersRoute(),
  CreatePartnerRoute(),
  CriteriasRoute(),
  CreateCriteriaRoute(),
  AnalyticsRoute(),
  ProfileRoute(),
  PartnerDetailsRoute(),
  EditPartnerRoute(),
];

BaseRoute<AppState> defaultRoute(User? user) =>
    user == null ? const LoginRoute() : const PartnersRoute();
