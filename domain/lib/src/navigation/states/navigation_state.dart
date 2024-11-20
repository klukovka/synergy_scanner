import 'package:clean_redux/clean_redux.dart';
import 'package:domain/src/navigation/actions/navigation_actions.dart';
import 'package:domain/src/navigation/entities/destination.dart';

class NavigationState extends State<NavigationState> {
  final List<Set<Destination>> previousRoutes;
  final Set<Destination> currentRoute;
  final Map<Destination, List<Set<Destination>>> routesHistory;

  NavigationState({
    this.previousRoutes = const [],
    required this.currentRoute,
    this.routesHistory = const {},
  }) : super(
          NavigationState._restore.reducer +
              NavigationState._close.reducer +
              NavigationState._open.reducer +
              NavigationState._replace.reducer +
              NavigationState._return.reducer,
        );

  factory NavigationState._restore(
    NavigationState state,
    RestoreRouteAction action,
  ) =>
      action.navigationState;

  factory NavigationState._close(
    NavigationState state,
    ClosePageAction action,
  ) =>
      state.copyWith(
        currentRoute:
            state.previousRoutes[state.previousRoutes.length - action.count],
        previousRoutes: state.previousRoutes
            .sublist(0, state.previousRoutes.length - action.count),
      );

  factory NavigationState._open(
    NavigationState state,
    OpenPageAction action,
  ) {
    if (state.currentRoute.contains(action.route)) return state;
    return state.copyWith(
      currentRoute: {
        ...state.currentRoute,
        action.route,
      },
      previousRoutes: [
        ...state.previousRoutes,
        state.currentRoute,
      ],
    );
  }

  factory NavigationState._return(
    NavigationState state,
    ReturnRouteWithSpecifiedRootAction action,
  ) {
    final newState = state.copyWith(
      routesHistory: {
        ...Map.fromEntries(
          state.routesHistory.entries
              .where((e) => e.key != action.rootDestination),
        ),
        state.currentRoute.first: [...state.previousRoutes, state.currentRoute],
      },
      currentRoute: state.routesHistory[action.rootDestination]?.last ??
          {action.rootDestination},
      previousRoutes: state.routesHistory[action.rootDestination]?.sublist(
              0, state.routesHistory[action.rootDestination]!.length - 1) ??
          [],
    );

    return newState;
  }

  factory NavigationState._replace(
    NavigationState state,
    ReplaceRouteAction action,
  ) =>
      state.copyWith(
        previousRoutes: action.previousRoutes ?? state.previousRoutes,
        currentRoute: action.route,
      );

  @override
  NavigationState copyWith({
    List<Set<Destination>>? previousRoutes,
    Set<Destination>? currentRoute,
    Map<Destination, List<Set<Destination>>>? routesHistory,
  }) =>
      NavigationState(
        previousRoutes: previousRoutes ?? this.previousRoutes,
        currentRoute: currentRoute ?? this.currentRoute,
        routesHistory: routesHistory ?? this.routesHistory,
      );
}
