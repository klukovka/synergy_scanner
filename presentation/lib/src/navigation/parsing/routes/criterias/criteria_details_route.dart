import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';
import 'package:presentation/src/navigation/base_route.dart';

class CriteriaDetailsRoute extends SimpleRoute<AppState> with WhenAuthorized {
  const CriteriaDetailsRoute()
      : super(
          destinations: const {
            Destination.criterias,
            Destination.criteriaDetails,
          },
          path: r'^\/criterias\/\d+$',
        );

  @override
  Uri getRouteInformation([AppState? state]) => Uri(
        path:
            '/criterias/${state?.tablesState.getTables<Criteria>().selectedItemId}',
      );

  @override
  Future<void> onOpenRoute(void Function(Action action) dispatch,
      [Uri? routeInformation]) async {
    super.onOpenRoute(dispatch, routeInformation);

    final ids = RegExp('[0-9]+').allMatches(routeInformation!.path);

    dispatch(SetSelectedIdAction<Criteria>(
      int.parse(ids.last.group(0)!),
    ));
  }
}
