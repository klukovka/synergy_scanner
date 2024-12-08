import 'package:domain/domain.dart';
import 'package:presentation/src/navigation/base_route.dart';

class AnalyticsRoute extends SimpleRoute<AppState> with WhenAuthorized {
  const AnalyticsRoute()
      : super(
          destinations: const {Destination.analytics},
          path: r'^/analytics$',
        );

  @override
  Uri getRouteInformation([AppState? state]) => Uri(path: '/analytics');
}
