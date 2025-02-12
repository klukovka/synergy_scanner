import 'package:clean_redux/clean_redux.dart';
import 'package:data/src/dtos/criterias/criteria_dto.dart';
import 'package:data/src/dtos/criterias/new_criteria_dto.dart';
import 'package:data/src/repositories/base_supabase_repository.dart';
import 'package:domain/domain.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide SortBy;

class CriteriasSupabaseRepository extends BaseSupabaseRepository {
  Future<FailureOrResult<int>> createCriteria(NewCriteria newCriteria) async {
    return await makeErrorHandledCallback(() async {
      final result = await supabase.from('criterias').insert(
        {
          ...NewCriteriaDto.fromDomain(newCriteria).toJson(),
          'user_id': supabase.auth.currentUser!.id,
        },
      ).select();
      final id = result.first['id'] as int;

      return FailureOrResult.success(id);
    });
  }

  Future<FailureOrResult<Criteria>> getCriteriaDetails(int id) async {
    return await makeErrorHandledCallback(() async {
      final result = await supabase.from('criterias').select().eq('id', id).eq(
            'user_id',
            supabase.auth.currentUser!.id,
          );
      return FailureOrResult.success(
        CriteriaDto.fromJson(result.first).toDomain(),
      );
    });
  }

  Future<FailureOrResult<Chunk<Criteria>>> getCriterias(Filter filter) async {
    return await makeErrorHandledCallback(() async {
      return await _getCriterias(
          supabase
              .from('criterias')
              .select()
              .eq('user_id', supabase.auth.currentUser!.id),
          filter);
    });
  }

  Future<FailureOrResult<Chunk<Criteria>>> getPartnerCriteriasWithMarks(
    Filter filter,
  ) async {
    return await makeErrorHandledCallback(() async {
      return await _getCriterias(
        supabase.rpc('get_marks_and_criteria', params: {
          'p_partner_id': filter.filters[FilterBy.partnerId]!.first,
          'p_user_id': supabase.auth.currentUser!.id,
        }),
        filter,
      );
    });
  }

  Future<FailureOrResult<Chunk<Criteria>>> _getCriterias(
    PostgrestFilterBuilder<List<Map<String, dynamic>>> query,
    Filter filter,
  ) async {
    return await makeErrorHandledCallback(() async {
      if (filter.search.isNotEmpty) {
        query = query.ilike('name', '%${filter.search}%');
      }

      final fullCount = (await query.count()).count;

      final ascending = filter.direction == Direction.asc;

      final result = await getPaginatedResponse(
        query.order(
            switch (filter.sortBy) {
              SortBy.coefficient => 'coefficient',
              SortBy.mark => 'mark',
              _ => 'name',
            },
            ascending: ascending),
        filter,
      );

      return FailureOrResult.success(Chunk(
        fullCount: fullCount,
        values:
            result.map((item) => CriteriaDto.fromJson(item).toDomain()).toSet(),
      ));
    });
  }
}
