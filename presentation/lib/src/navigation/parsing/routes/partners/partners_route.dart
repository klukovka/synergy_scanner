import 'package:domain/domain.dart';
import 'package:presentation/src/navigation/base_route.dart';

class PartnersRoute extends SimpleRoute<AppState> with WhenAuthorized {
  const PartnersRoute()
      : super(
          destinations: const {Destination.partners},
          path: r'^/partners$',
        );

  @override
  Uri getRouteInformation([AppState? state]) => Uri(path: '/partners');
}
