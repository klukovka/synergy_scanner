import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';
import 'package:presentation/src/navigation/base_route.dart';

class PartnerDetailsRoute extends SimpleRoute<AppState> with WhenAuthorized {
  const PartnerDetailsRoute()
      : super(
          destinations: const {
            Destination.partners,
            Destination.partnerDetails,
          },
          path: r'^\/partners\/\d+$',
        );

  @override
  Uri getRouteInformation([AppState? state]) => Uri(
        path:
            '/partners/${state?.tablesState.getTables<Partner>().selectedItemId}',
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
