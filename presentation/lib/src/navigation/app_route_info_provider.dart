import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:redux/redux.dart';

class AppRouteInformationProvider extends RouteInformationProvider
    with WidgetsBindingObserver, ChangeNotifier {
  final Store<AppState> store;

  /// Create a platform route information provider.
  ///
  /// Use the [initialRouteInformation] to set the default route information for this
  /// provider.
  AppRouteInformationProvider({
    required RouteInformation initialRouteInformation,
    required this.store,
  }) : _value = initialRouteInformation {
    if (kFlutterMemoryAllocationsEnabled) {
      ChangeNotifier.maybeDispatchObjectCreation(this);
    }
  }

  static bool _equals(Uri a, Uri b) {
    if (a.queryParametersAll.length != b.queryParametersAll.length) {
      return false;
    }

    for (final key in a.queryParametersAll.keys) {
      if (a.queryParametersAll[key] != b.queryParametersAll[key]) {
        return false;
      }
    }

    return a.path == b.path && a.fragment == b.fragment;
  }

  @override
  void routerReportsNewRouteInformation(RouteInformation routeInformation,
      {RouteInformationReportingType type =
          RouteInformationReportingType.none}) async {
    final bool replace = type == RouteInformationReportingType.neglect ||
        (type == RouteInformationReportingType.none &&
            _equals(_valueInEngine.uri, routeInformation.uri));
    SystemNavigator.selectMultiEntryHistory();
    await SystemNavigator.routeInformationUpdated(
      uri: routeInformation.uri,
      state: routeInformation.state,
      replace: replace,
    );
    _value = routeInformation;
    _valueInEngine = routeInformation;
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: store.state.navigationState.currentRoute.last.displayName,
        primaryColor: Colors.white.value,
      ),
    );
  }

  @override
  RouteInformation get value => _value;
  RouteInformation _value;

  RouteInformation _valueInEngine = RouteInformation(
      uri: Uri.parse(
          WidgetsBinding.instance.platformDispatcher.defaultRouteName));

  void _platformReportsNewRouteInformation(RouteInformation routeInformation) {
    if (_value == routeInformation) {
      return;
    }
    _value = routeInformation;
    _valueInEngine = routeInformation;
    notifyListeners();
  }

  @override
  void addListener(VoidCallback listener) {
    if (!hasListeners) {
      WidgetsBinding.instance.addObserver(this);
    }
    super.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    super.removeListener(listener);
    if (!hasListeners) {
      WidgetsBinding.instance.removeObserver(this);
    }
  }

  @override
  void dispose() {
    // In practice, this will rarely be called. We assume that the listeners
    // will be added and removed in a coherent fashion such that when the object
    // is no longer being used, there's no listener, and so it will get garbage
    // collected.
    if (hasListeners) {
      WidgetsBinding.instance.removeObserver(this);
    }
    super.dispose();
  }

  @override
  Future<bool> didPushRouteInformation(
      RouteInformation routeInformation) async {
    assert(hasListeners);
    _platformReportsNewRouteInformation(routeInformation);
    return true;
  }
}

extension on Destination {
  String get displayName => switch (this) {
        Destination.login => 'Login',
        Destination.signUp => 'Sign Up',
        Destination.unexpectedError => 'Error',
        Destination.partners => 'Partners',
        Destination.criterias => 'Criterias',
        Destination.analytics => 'Analytics',
        Destination.profile => 'Profile',
        Destination.createPartner => 'Create Partner',
        Destination.partnersFilters => 'Filters',
        Destination.createCriteria => 'Create Criteria',
        Destination.criteriasFilters => 'Filters',
        Destination.partnerDetails => 'Partner Details',
        Destination.partnerCriteriasFilters => 'Filters',
      };
}
