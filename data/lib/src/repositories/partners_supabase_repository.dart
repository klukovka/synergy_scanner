import 'package:clean_redux/clean_redux.dart';
import 'package:data/src/dtos/partners/new_partner_dto.dart';
import 'package:data/src/dtos/partners/partner_dto.dart';
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

  Future<FailureOrResult<Chunk<Partner>>> getPartners(Filter filter) async {
    return await makeErrorHandledCallback(() async {
      var query = supabase
          .from('partners')
          .select()
          .eq('user_id', supabase.auth.currentUser!.id);

      if (filter.search.isNotEmpty) {
        query = query.textSearch('name', filter.search,
            type: TextSearchType.websearch);
      }
      final filterByType = filter.filters[FilterBy.type];
      if (filterByType != null) {
        query = query.filter('type', 'in', filterByType.toFilter());
      }

      final fullCount = (await query.count()).count;

      final ascending = filter.direction == Direction.asc;

      final result = await getPaginatedResponse(
        switch (filter.sortBy) {
          SortBy.type => query.order('type', ascending: ascending),
          SortBy.name => query.order('name', ascending: ascending),
          _ => query.order('average_mark', ascending: ascending),
        },
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
