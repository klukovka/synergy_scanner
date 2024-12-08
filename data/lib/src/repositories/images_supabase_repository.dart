import 'package:clean_redux/clean_redux.dart';
import 'package:data/src/repositories/base_supabase_repository.dart';
import 'package:domain/domain.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImagesSupabaseRepository extends BaseSupabaseRepository {
  Future<FailureOrResult<String>> uploadImage({
    required NewImage photo,
    required String bucket,
    required String name,
  }) async {
    return await makeErrorHandledCallback(() async {
      final filepath = '$name.${photo.extension}';
      try {
        await supabase.storage.from(bucket).updateBinary(
              filepath,
              photo.bytes,
              fileOptions: FileOptions(contentType: photo.mimeType),
            );
      } catch (e) {
        await supabase.storage.from(bucket).uploadBinary(
              filepath,
              photo.bytes,
              fileOptions: FileOptions(contentType: photo.mimeType),
            );
      }
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
