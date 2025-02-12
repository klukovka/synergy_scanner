import 'package:clean_redux/clean_redux.dart';
import 'package:data/src/dtos/partners/new_partner_dto.dart';
import 'package:data/src/dtos/partners/partner_dto.dart';
import 'package:data/src/dtos/partners/patch_partner_dto.dart';
import 'package:data/src/repositories/images_supabase_repository.dart';
import 'package:data/src/units/extensions/supabase_filter_extension.dart';
import 'package:domain/domain.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide SortBy;

class PartnersSupabaseRepository extends ImagesSupabaseRepository {
  Future<FailureOrResult<int>> createPartner(NewPartner newPartner) async {
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

      return FailureOrResult.success(id);
    });
  }

  Future<FailureOrResult<Partner>> updatePartner(
    int id,
    PatchPartner patchPartner,
  ) async {
    return await makeErrorHandledCallback(() async {
      final result = await supabase
          .from('partners')
          .update(PatchPartnerDto.fromDomain(patchPartner).toJson())
          .eq('id', id)
          .select();

      if (patchPartner.avatar != null) {
        await uploadParnerAvatar(photo: patchPartner.avatar!, id: id);
      }

      return FailureOrResult.success(
        PartnerDto.fromJson(result.first).toDomain(),
      );
    });
  }

  Future<FailureOrResult<String>> uploadParnerAvatar({
    required NewImage photo,
    required int id,
  }) async {
    return await makeErrorHandledCallback(() async {
      final result = await uploadImage(
        photo: photo,
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

  Future<FailureOrResult<void>> deletePartner(int id) async {
    return await makeErrorHandledCallback(() async {
      await supabase.from('partners').delete().eq('id', id);
      return FailureOrResult.success(null);
    });
  }

  Future<FailureOrResult<Chunk<Partner>>> getPartners(Filter filter) async {
    return await makeErrorHandledCallback(() async {
      return await _getPartners(
        filter: filter,
        query: supabase
            .from('partners')
            .select()
            .eq('user_id', supabase.auth.currentUser!.id),
      );
    });
  }

  Future<FailureOrResult<Chunk<Partner>>> getPartnersWithMark(
    Filter filter,
  ) async {
    return await makeErrorHandledCallback(() async {
      return await _getPartners(
        filter: filter,
        query: supabase.rpc('get_partner_marks', params: {
          'custom_criteria_id': filter.filters[FilterBy.criteriaId]!.first,
          'custom_user_id': supabase.auth.currentUser!.id,
        }),
      );
    });
  }

  Future<FailureOrResult<Chunk<Partner>>> _getPartners({
    required Filter filter,
    required PostgrestFilterBuilder<List<Map<String, dynamic>>> query,
  }) async {
    return await makeErrorHandledCallback(() async {
      query = supabase
          .from('partners')
          .select()
          .eq('user_id', supabase.auth.currentUser!.id);

      if (filter.search.isNotEmpty) {
        query = query.ilike('name', '%${filter.search}%');
      }
      final filterByType = filter.filters[FilterBy.type];
      if (filterByType != null) {
        query = query.filter('type', 'in', filterByType.toFilter());
      }

      final fullCount = (await query.count()).count;

      final ascending = filter.direction == Direction.asc;

      final result = await getPaginatedResponse(
        query.order(
          switch (filter.sortBy) {
            SortBy.type => 'type',
            SortBy.name => 'name',
            SortBy.mark => 'mark',
            _ => 'average_mark',
          },
          ascending: ascending,
        ),
        filter,
      );

      return FailureOrResult.success(Chunk(
        fullCount: fullCount,
        values:
            result.map((item) => PartnerDto.fromJson(item).toDomain()).toSet(),
      ));
    });
  }
}
