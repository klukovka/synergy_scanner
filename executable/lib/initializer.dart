import 'package:clean_redux/clean_redux.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:presentation/presentation.dart';
import 'package:redux/redux.dart';

class Initializer {
  Future<Store<AppState>> initialize() async {
    final userRepository = UserSupabaseRepository();

    Store<AppState>? store;

    final appState = await _initializeAppState(
      userRepository,
    );

    store = Store<AppState>(
      (state, action) =>
          action is Action ? appState.reducer(state, action) : state,
      distinct: true,
      initialState: appState,
      middleware: [],
    );

    return store;
  }

  Future<AppState> _initializeAppState(
    UserSupabaseRepository userRepository,
  ) async {
    final user = (await userRepository.getCurrentUser()).result;

    final appRoute = await AppRouteParser(
      () => user,
    ).parseRouteInformation(
      RouteInformation(
        //Replace dashboard for correct handle prod route
        uri: Uri(
          path: Uri.base.path,
          queryParameters: Uri.base.queryParameters,
          fragment: Uri.base.fragment,
        ),
      ),
    );

    final navigationState = appRoute.getNavigationState(Uri.base);

    return AppState.initial(
      currentUserState: CurrentUserState(user: user),
      navigationState: navigationState,
    );
  }
}
