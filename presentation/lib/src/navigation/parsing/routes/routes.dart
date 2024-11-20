import 'package:domain/domain.dart';
import 'package:presentation/src/navigation/base_route.dart';
import 'package:presentation/src/navigation/parsing/routes/home_route.dart';
import 'package:presentation/src/navigation/parsing/routes/login_route.dart';

const routes = <BaseRoute<AppState>>[
  LoginRoute(),
  HomeRoute(),
];

BaseRoute<AppState> defaultRoute(User? user) =>
    user == null ? const LoginRoute() : const HomeRoute();
