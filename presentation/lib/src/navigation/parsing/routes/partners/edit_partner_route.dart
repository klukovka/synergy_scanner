import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';
import 'package:presentation/src/navigation/base_route.dart';

class EditPartnerRoute extends SimpleRoute<AppState> with WhenAuthorized {
  const EditPartnerRoute()
      : super(
          destinations: const {
            Destination.partners,
            Destination.partnerDetails,
          },
          path: r'^\/partners\/\d+\/edit$',
        );

  @override
  Uri getRouteInformation([AppState? state]) => Uri(
        path:
            '/partners/${state?.tablesState.getTables<Partner>().selectedItemId}/edit',
      );

  @override
  Future<void> onOpenRoute(void Function(Action action) dispatch,
      [Uri? routeInformation]) async {
    super.onOpenRoute(dispatch, routeInformation);

    final ids = RegExp('[0-9]+').allMatches(routeInformation!.path);

    dispatch(SetSelectedIdAction<Partner>(
      int.parse(ids.last.group(0)!),
    ));
  }
}
