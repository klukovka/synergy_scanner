import 'dart:async';

import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';

abstract class BaseRoute<T> {
  final String path;
  final Set<String> queryParameters;

  const BaseRoute({
    required this.path,
    this.queryParameters = const {},
  });

  bool isAccessiable(User? user);

  Uri getRouteInformation([T? state]) => Uri.parse(path);

  Set<Destination> getCurrentRoute(Uri uri);

  List<Set<Destination>> getPreviousRoutes(Set<Destination> currentRoute) =>
      List.generate(
        currentRoute.length - 1,
        (index) => currentRoute.take(index + 1).toSet(),
      );

  NavigationState getNavigationState(Uri uri) {
    final currentRoute = getCurrentRoute(uri);

    return NavigationState(
      currentRoute: currentRoute,
      previousRoutes: getPreviousRoutes(currentRoute),
    );
  }

  Future<void> onOpenRoute(
    void Function(Action action) dispatch, [
    Uri? routeInformation,
  ]) async {
    dispatch(RestoreRouteAction(getNavigationState(routeInformation!)));
  }

  Future<bool> canClose() async => true;

  bool isConsistent(List<Destination> destinations);
}

class ProxyRoute<T> extends BaseRoute<T> {
  final Uri? routeInformation;
  final Store<T>? store;
  final BaseRoute<T> route;

  ProxyRoute({
    required this.route,
    this.routeInformation,
    this.store,
  }) : super(
          path: route.path,
          queryParameters: route.queryParameters,
        );

  @override
  bool isAccessiable(User? user) => route.isAccessiable(user);

  @override
  Set<Destination> getCurrentRoute(Uri uri) => route.getCurrentRoute(uri);

  @override
  Uri getRouteInformation([T? state]) =>
      route.getRouteInformation(this.store?.state ?? state);

  @override
  Future<void> onOpenRoute(
    void Function(Action action) dispatch, [
    Uri? routeInformation,
  ]) =>
      route.onOpenRoute(dispatch, this.routeInformation ?? routeInformation);

  @override
  bool isConsistent(List<Destination> destinations) =>
      route.isConsistent(destinations);
}

abstract class SimpleRoute<T> extends BaseRoute<T> {
  final Set<Destination> destinations;

  const SimpleRoute({
    required super.path,
    required this.destinations,
    super.queryParameters = const {},
  });

  @override
  Set<Destination> getCurrentRoute(Uri uri) => destinations;

  @override
  bool isConsistent(List<Destination> destinations) => listEquals(
        destinations,
        this.destinations.toList(),
      );
}

mixin WhenAuthorized<T> on BaseRoute<T> {
  @override
  bool isAccessiable(User? user) => user != null;
}

mixin WhenUnauthorized<T> on BaseRoute<T> {
  @override
  bool isAccessiable(User? user) => user == null;
}
