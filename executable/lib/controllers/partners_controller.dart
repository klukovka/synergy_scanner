import 'package:clean_redux/clean_redux.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:redux/redux.dart';

class PartnersController extends Controller {
  PartnersController(Store<AppState> Function() store,
      PartnersSupabaseRepository partnersRepository)
      : super([
          Endpoint(
            CreatePartner(partnersRepository.createPartner),
          ).call,
        ]);
}
