import 'package:domain/domain.dart';
import 'package:presentation/src/navigation/base_route.dart';

class LoginRoute extends SimpleRoute<AppState> with WhenUnauthorized {
  const LoginRoute()
      : super(
          destinations: const {Destination.login},
          path: r'^/login$',
        );

  @override
  Uri getRouteInformation([AppState? state]) => Uri.parse('/login');
}
