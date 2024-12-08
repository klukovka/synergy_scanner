import 'package:domain/domain.dart';
import 'package:presentation/src/navigation/base_route.dart';
import 'package:presentation/src/navigation/parsing/routes/analytics_route.dart';
import 'package:presentation/src/navigation/parsing/routes/criterias_route.dart';
import 'package:presentation/src/navigation/parsing/routes/login_route.dart';
import 'package:presentation/src/navigation/parsing/routes/partners_route.dart';
import 'package:presentation/src/navigation/parsing/routes/profile_route.dart';

const routes = <BaseRoute<AppState>>[
  LoginRoute(),
  PartnersRoute(),
  CriteriasRoute(),
  AnalyticsRoute(),
  ProfileRoute(),
];

BaseRoute<AppState> defaultRoute(User? user) =>
    user == null ? const LoginRoute() : const PartnersRoute();
