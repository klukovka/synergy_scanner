import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:presentation/src/navigation/base_route.dart';
import 'package:presentation/src/navigation/parsing/routes/routes.dart';

class AppRouteParser extends RouteInformationParser<BaseRoute<AppState>> {
  final User? Function() getUser;

  AppRouteParser(
    this.getUser,
  );

  @override
  Future<BaseRoute<AppState>> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    return ProxyRoute(
      route: routes.firstWhere(
        (route) =>
            setEquals(
              route.queryParameters,
              routeInformation.uri.queryParameters.keys.toSet(),
            ) &&
            RegExp(route.path).hasMatch(routeInformation.uri.path) &&
            route.isAccessiable(getUser()),
        orElse: () => defaultRoute(getUser()),
      ),
      routeInformation: routeInformation.uri,
    );
  }

  @override
  RouteInformation? restoreRouteInformation(
    BaseRoute<AppState> configuration,
  ) =>
      RouteInformation(uri: configuration.getRouteInformation());
}
