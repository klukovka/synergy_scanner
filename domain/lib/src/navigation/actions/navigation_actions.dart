import 'package:clean_redux/clean_redux.dart';
import 'package:domain/src/navigation/entities/destination.dart';
import 'package:domain/src/navigation/states/navigation_state.dart';

class RestoreRouteAction extends Action {
  final NavigationState navigationState;

  RestoreRouteAction(this.navigationState);

  @override
  List<Object?> get properties => [navigationState];
}

class ClosePageAction extends Action {
  final int count;

  ClosePageAction({this.count = 1});

  @override
  List<Object?> get properties => [count];
}

class OpenErrorDialogAction extends OpenPageAction {
  final String? title;
  final String? message;
  final bool shouldCloseCurrentPage;

  OpenErrorDialogAction(
    this.title,
    this.message, {
    this.shouldCloseCurrentPage = false,
  }) : super(Destination.unexpectedError);

  @override
  List<Object?> get properties => [message];
}

class OpenPageAction extends Action {
  final Destination route;

  OpenPageAction(this.route);

  @override
  List<Object?> get properties => [route];
}

class ReplaceRouteAction extends Action {
  final Set<Destination> route;
  final List<Set<Destination>>? previousRoutes;

  ReplaceRouteAction(this.route, {this.previousRoutes});

  @override
  List<Object> get properties => [route];
}

class ReturnRouteWithSpecifiedRootAction extends Action {
  final Destination rootDestination;

  ReturnRouteWithSpecifiedRootAction(this.rootDestination);

  @override
  List<Object> get properties => [rootDestination];
}
