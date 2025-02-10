import 'package:domain/domain.dart';
import 'package:presentation/src/navigation/base_route.dart';

class CreatePartnerRoute extends SimpleRoute<AppState> with WhenAuthorized {
  const CreatePartnerRoute()
      : super(
          destinations: const {Destination.partners, Destination.createPartner},
          path: r'^/partners/create$',
        );

  @override
  Uri getRouteInformation([AppState? state]) => Uri(path: '/partners/create');
}
