import 'package:domain/domain.dart';
import 'package:presentation/src/navigation/base_route.dart';

class CreateCriteriaRoute extends SimpleRoute<AppState> with WhenAuthorized {
  const CreateCriteriaRoute()
      : super(
          destinations: const {
            Destination.criterias,
            Destination.createCriteria
          },
          path: r'^/criterias/create$',
        );

  @override
  Uri getRouteInformation([AppState? state]) => Uri(path: '/criterias/create');
}
