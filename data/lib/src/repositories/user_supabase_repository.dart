import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class UserSupabaseRepository {
  Future<FailureOrResult<User>> login(String email, String password) async =>
      FailureOrResult.success(
        User(id: 0, name: 'name'),
      );

  Future<FailureOrResult<User>> getCurrentUser() async =>
      FailureOrResult.success(
        User(id: 0, name: 'name'),
      );
}
