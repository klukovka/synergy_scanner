import 'package:clean_redux/clean_redux.dart';
import 'package:data/src/repositories/base_supabase_repository.dart';
import 'package:domain/domain.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

class UserSupabaseRepository extends BaseSupabaseRepository {
  UserSupabaseRepository();

  Future<FailureOrResult<User>> login(String email, String password) async =>
      FailureOrResult.success(
        User(id: '', fullname: 'name', email: ''),
      );

  Future<FailureOrResult<User>> getCurrentUser() async =>
      FailureOrResult.success(
        User(id: '', fullname: 'name', email: ''),
      );

  Future<FailureOrResult<User>> signUp(NewUser newUser) async {
    return await makeErrorHandledCallback(() async {
      final response = await supabase.auth.signUp(
        password: newUser.password,
        email: newUser.email,
        data: {
          'full_name': newUser.name,
          'email': newUser.email,
          'avatar_url': newUser.photo?.filepath,
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
          ? await uploadImage(newUser.photo!, 'avatars')
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

  Future<FailureOrResult<String>> uploadImage(
    NewImage photo,
    String bucket,
  ) async {
    return await makeErrorHandledCallback(() async {
      await supabase.storage.from(bucket).updateBinary(
            photo.filepath,
            photo.bytes,
            fileOptions: FileOptions(contentType: photo.mimeType),
          );
      return await getImage(filepath: photo.filepath, bucket: bucket);
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
