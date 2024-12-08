import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:executable/controllers/user_controller.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

class ControllersMiddleware extends EpicMiddleware<AppState> {
  ControllersMiddleware(
    Store<AppState> Function() store, {
    required UserSupabaseRepository userRepository,
  }) : super(
          () {
            return combineEpics<AppState>(
              [
                ...UserController(store, userRepository),
              ].toList(),
            );
          }(),
        );
}
