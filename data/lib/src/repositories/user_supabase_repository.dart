import 'package:clean_redux/clean_redux.dart';
import 'package:data/src/dtos/user/user_dto.dart';
import 'package:data/src/repositories/base_supabase_repository.dart';
import 'package:domain/domain.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

class UserSupabaseRepository extends BaseSupabaseRepository {
  UserSupabaseRepository();

  Future<FailureOrResult<User>> login(String email, String password) async =>
      FailureOrResult.success(
        User(id: '', fullname: 'name', email: ''),
      );

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

      final avatarUrl = newUser.photo != null
          ? await uploadUserAvatar(photo: newUser.photo!, id: user.id)
          : null;

      return FailureOrResult.success(
        User(
          id: user.id,
          fullname: user.userMetadata?['full_name'] ?? '',
          email: user.email ?? '',
          avatarUrl: avatarUrl?.result,
        ),
      );
    });
  }

  Future<FailureOrResult<String>> uploadUserAvatar({
    required NewImage photo,
    required String id,
  }) async {
    return await makeErrorHandledCallback(() async {
      final filepath = '$id.${photo.extension}';
      final result = await uploadImage(
        photo: photo,
        bucket: 'avatars',
        name: id,
      );

      if (result.wasSuccessful) {
        await supabase.from('users').update({'avatar_url': filepath}).eq(
          'id',
          id,
        );
      }

      return result;
    });
  }

  Future<FailureOrResult<String>> uploadImage({
    required NewImage photo,
    required String bucket,
    required String name,
  }) async {
    return await makeErrorHandledCallback(() async {
      final filepath = '$name.${photo.extension}';
      await supabase.storage.from(bucket).updateBinary(
            filepath,
            photo.bytes,
            fileOptions: FileOptions(contentType: photo.mimeType),
          );
      return await getImage(filepath: filepath, bucket: bucket);
    });
  }

  Future<FailureOrResult<String>> getImage({
    required String filepath,
    required String bucket,
  }) async {
    return await makeErrorHandledCallback(() async {
      final imageUrlResponse = await supabase.storage
          .from(bucket)
          .createSignedUrl(filepath, 60 * 60 * 24 * 365 * 10);

      return FailureOrResult.success(imageUrlResponse);
    });
  }
}
