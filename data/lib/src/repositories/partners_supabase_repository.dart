import 'package:clean_redux/clean_redux.dart';
import 'package:data/src/dtos/partners/new_partner_dto.dart';
import 'package:data/src/dtos/partners/partner_dto.dart';
import 'package:data/src/repositories/images_supabase_repository.dart';
import 'package:domain/domain.dart';

class PartnersSupabaseRepository extends ImagesSupabaseRepository {
  Future<FailureOrResult<Partner>> createPartner(NewPartner newPartner) async {
    return await makeErrorHandledCallback(() async {
      final result = await supabase.from('partners').insert(
        {
          ...NewPartnerDto.fromDomain(newPartner).toJson(),
          'user_id': supabase.auth.currentUser!.id,
        },
      ).select();
      final id = result.first['id'] as int;

      if (newPartner.avatar != null) {
        await uploadParnerAvatar(photo: newPartner.avatar!, id: id);
      }

      return await getPartnerDetails(id);
    });
  }

  Future<FailureOrResult<String>> uploadParnerAvatar({
    required NewImage photo,
    required int id,
  }) async {
    return await makeErrorHandledCallback(() async {
      final result = await uploadImage(
        photo: photo,
        bucket: 'partner_avatars',
        name: '${supabase.auth.currentUser!.id}_partner_$id',
      );

      if (result.wasSuccessful) {
        await supabase
            .from('partners')
            .update({'avatar_url': result.result!}).eq(
          'id',
          id,
        );
      }

      return result;
    });
  }

  Future<FailureOrResult<Partner>> getPartnerDetails(int id) async {
    return await makeErrorHandledCallback(() async {
      final result = await supabase.from('partners').select().eq('id', id).eq(
            'user_id',
            supabase.auth.currentUser!.id,
          );
      return FailureOrResult.success(
        PartnerDto.fromJson(result.first).toDomain(),
      );
    });
  }
}
