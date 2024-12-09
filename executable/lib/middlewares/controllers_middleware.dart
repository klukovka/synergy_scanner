import 'package:clean_redux/clean_redux.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:executable/controllers/partners_controller.dart';
import 'package:executable/controllers/tables_controller.dart';
import 'package:executable/controllers/user_controller.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

class ControllersMiddleware extends EpicMiddleware<AppState> {
  ControllersMiddleware(
    Store<AppState> Function() store, {
    required UserSupabaseRepository userRepository,
    required PartnersSupabaseRepository partnersRepository,
  }) : super(
          () {
            return combineEpics<AppState>(
              [
                ...Controller([Endpoint(ReloadData()).call]),
                ...UserController(store, userRepository),
                ...PartnersController(store, partnersRepository),
                ...TablesController(store, partnersRepository),
              ].toList(),
            );
          }(),
        );
}
