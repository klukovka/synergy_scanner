import 'dart:ui';

import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:presentation/src/auth/login/login_page.dart';
import 'package:presentation/src/auth/sign_up/sign_up_page.dart';
import 'package:presentation/src/general/dialogs/material_dialog.dart';
import 'package:presentation/src/general/dialogs/unexpected_error_dialog.dart';
import 'package:presentation/src/home/home_page.dart';
import 'package:presentation/src/navigation/base_route.dart';
import 'package:presentation/src/navigation/fade_transition_page.dart';
import 'package:presentation/src/navigation/parsing/routes/routes.dart';
import 'package:redux/redux.dart';

class AppRouterDelegate extends RouterDelegate<BaseRoute<AppState>>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BaseRoute<AppState>> {
  final Store<AppState> store;
  final List<BaseRoute<AppState>> routes;

  AppRouterDelegate(
    this.store,
    this.routes,
  );

  @override
  final navigatorKey = const GlobalObjectKey<NavigatorState>('navigatorKey');

  @override
  Future<bool> popRoute() async {
    final navigationState = store.state.navigationState;

    if (navigationState.previousRoutes.isEmpty) {
      return false;
    }

    final canPopPage =
        await _onPopForm(navigationState.currentRoute.last) ?? true;

    if (canPopPage) {
      store.dispatch(ClosePageAction());
    }
    return true;
  }

  Future<bool?> _onPopForm(Destination destination) async => null;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, NavigationViewModel>(
      distinct: true,
      converter: NavigationViewModel.new,
      onWillChange: (oldViewModel, newViewModel) {
        notifyListeners();
      },
      builder: (context, viewModel) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1),
          ),
          child: Navigator(
            key: navigatorKey,
            onDidRemovePage: (route) {
              if (viewModel.previousRoutes.isNotEmpty) {
                store.dispatch(ClosePageAction());
              }
            },
            pages: viewModel.currentRoute.expand<Page>((destination) sync* {
              switch (destination) {
                case Destination.unexpectedError:
                  yield MaterialDialog(
                    key: const ValueKey(Destination.unexpectedError),
                    imageFilter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    barrierColor: Colors.black.withOpacity(0.16),
                    child: const UnexpectedErrorDialog(),
                  );
                  break;
                case Destination.login:
                  yield const FadeTransitionPage(
                    key: ValueKey(Destination.login),
                    child: LoginPage(),
                  );
                  break;
                case Destination.signUp:
                  yield const FadeTransitionPage(
                    key: ValueKey(Destination.signUp),
                    child: SignUpPage(),
                  );
                  break;
                case Destination.home:
                  yield const FadeTransitionPage(
                    key: ValueKey(Destination.home),
                    child: HomePage(),
                  );
                  break;

                default:
                  break;
              }
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  BaseRoute<AppState>? get currentConfiguration => ProxyRoute(
        route: routes.firstWhereOrNull(
              (route) => route.isConsistent(
                store.state.navigationState.currentRoute
                    .where((x) => x.canBePartOfRoute)
                    .toList(),
              ),
            ) ??
            defaultRoute(store.state.currentUserState.user),
        store: store,
      );

  @override
  Future<void> setNewRoutePath(BaseRoute<AppState> configuration) async {
    final currentRoute = routes.firstWhereOrNull(
      (route) => route.isConsistent(
        store.state.navigationState.currentRoute.toList(),
      ),
    );

    if (currentRoute != null) {
      final canClose = await currentRoute.canClose();
      if (!canClose) return;
    }

    configuration.onOpenRoute(store.dispatch);
  }
}

class NavigationViewModel with EquatableMixin {
  final Set<Destination> currentRoute;
  final List<Set<Destination>> previousRoutes;

  NavigationViewModel(Store<AppState> store)
      : currentRoute = store.state.navigationState.currentRoute,
        previousRoutes = store.state.navigationState.previousRoutes;

  @override
  List<Object?> get props => [currentRoute, previousRoutes];
}
