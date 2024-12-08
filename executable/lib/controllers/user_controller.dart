import 'package:clean_redux/clean_redux.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:redux/redux.dart';

class UserController extends Controller {
  UserController(
    Store<AppState> Function() store,
    UserSupabaseRepository userRepository,
  ) : super(
          [
            Endpoint(SignUp(userRepository.signUp)).call,
          ],
        );
}
