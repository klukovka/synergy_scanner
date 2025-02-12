import 'package:domain/domain.dart';
import 'package:presentation/src/navigation/base_route.dart';

class CriteriasRoute extends SimpleRoute<AppState> with WhenAuthorized {
  const CriteriasRoute()
      : super(
          destinations: const {Destination.criterias},
          path: r'^/criterias$',
        );

  @override
  Uri getRouteInformation([AppState? state]) => Uri(path: '/criterias');
}
