import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';
import 'package:presentation/src/navigation/base_route.dart';

class EditCriteriaRoute extends SimpleRoute<AppState> with WhenAuthorized {
  const EditCriteriaRoute()
      : super(
          destinations: const {
            Destination.criterias,
            Destination.criteriaDetails,
            Destination.editCriteria,
          },
          path: r'^\/criterias\/\d+\/edit$',
        );

  @override
  Uri getRouteInformation([AppState? state]) => Uri(
        path:
            '/criterias/${state?.tablesState.getTables<Criteria>().selectedItemId}/edit',
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
