import 'package:clean_redux/clean_redux.dart';
import 'package:data/src/dtos/user/user_dto.dart';
import 'package:data/src/repositories/images_supabase_repository.dart';
import 'package:domain/domain.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

class UserSupabaseRepository extends ImagesSupabaseRepository {
  UserSupabaseRepository();

  Future<FailureOrResult<User>> login(LoginUser loginUser) async {
    return await makeErrorHandledCallback(() async {
      await supabase.auth.signInWithPassword(
        password: loginUser.password,
        email: loginUser.email,
      );

      return await getCurrentUser();
    });
  }

  Future<FailureOrResult<User>> getCurrentUser() async {
    return await makeErrorHandledCallback(() async {
      if (supabase.auth.currentSession != null &&
          supabase.auth.currentUser != null) {
        final id = supabase.auth.currentUser!.id;
        final data = (await supabase.from('users').select().eq('id', id)).first;

        return FailureOrResult.success(UserDto.fromJson(data).toDomain());
      } else if (supabase.auth.currentSession == null &&
          supabase.auth.currentUser != null) {
        await supabase.auth.refreshSession();
        return await getCurrentUser();
      }

      return FailureOrResult.success(null);
    });
  }

  Future<FailureOrResult<User>> signUp(NewUser newUser) async {
    return await makeErrorHandledCallback(() async {
      final response = await supabase.auth.signUp(
        password: newUser.password,
        email: newUser.email,
        data: {
          'full_name': newUser.name,
          'email': newUser.email,
        },
      );

      final user = response.user;

      if (user == null) {
        return FailureOrResult.failure(
          code: '404',
          message: 'User doesn\'t exist',
        );
      }

      if (newUser.photo != null) {
        await uploadUserAvatar(photo: newUser.photo!, id: user.id);
      }

      return await login(
        LoginUser(email: newUser.email, password: newUser.password),
      );
    });
  }

  Future<FailureOrResult<String>> uploadUserAvatar({
    required NewImage photo,
    required String id,
  }) async {
    return await makeErrorHandledCallback(() async {
      final result = await uploadImage(
        photo: photo,
        name: id,
      );

      if (result.wasSuccessful) {
        await supabase.from('users').update({'avatar_url': result.result!}).eq(
          'id',
          id,
        );
      }

      return result;
    });
  }

  Future<FailureOrResult<void>> logout() async {
    return await makeErrorHandledCallback(() async {
      await supabase.auth.signOut();
      return FailureOrResult.success(null);
    });
  }

  Future<FailureOrResult<User>> updateUser(PatchUser patchUser) async {
    return await makeErrorHandledCallback(() async {
      final user = (await getCurrentUser()).result!;
      if (user.email != patchUser.email ||
          user.fullname != patchUser.fullName) {
        await supabase.auth.updateUser(
          UserAttributes(
            email: user.email != patchUser.email ? patchUser.email : null,
            data: patchUser.fullName != null &&
                    user.fullname != patchUser.fullName
                ? {
                    'full_name': patchUser.fullName,
                  }
                : null,
          ),
        );
      }

      if (patchUser.photo != null) {
        await uploadUserAvatar(photo: patchUser.photo!, id: user.id);
      }

      return await getCurrentUser();
    });
  }
}
