import 'package:domain/domain.dart';
import 'package:presentation/src/navigation/base_route.dart';

class ProfileRoute extends SimpleRoute<AppState> with WhenAuthorized {
  const ProfileRoute()
      : super(
          destinations: const {Destination.profile},
          path: r'^/profile$',
        );

  @override
  Uri getRouteInformation([AppState? state]) => Uri(path: '/profile');
}
