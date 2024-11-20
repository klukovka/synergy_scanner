import 'package:domain/domain.dart';
import 'package:presentation/src/navigation/base_route.dart';

class HomeRoute extends SimpleRoute<AppState> with WhenAuthorized {
  const HomeRoute()
      : super(
          destinations: const {Destination.home},
          path: r'^/home$',
        );

  @override
  Uri getRouteInformation([AppState? state]) => Uri(path: '/home');
}
