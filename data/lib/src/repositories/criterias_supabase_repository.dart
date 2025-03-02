import 'package:clean_redux/clean_redux.dart';
import 'package:data/src/dtos/criterias/criteria_dto.dart';
import 'package:data/src/dtos/criterias/criterias_correlation_dto.dart';
import 'package:data/src/dtos/criterias/new_criteria_dto.dart';
import 'package:data/src/dtos/criterias/patch_criteria_dto.dart';
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

  Future<FailureOrResult<void>> deleteCriteria(int id) async {
    return await makeErrorHandledCallback(() async {
      await supabase.from('criterias').delete().eq('id', id);
      return FailureOrResult.success(null);
    });
  }

  Future<FailureOrResult<Criteria>> updateCriteria(
    int id,
    PatchCriteria patchCriteria,
  ) async {
    return await makeErrorHandledCallback(() async {
      final result = await supabase
          .from('criterias')
          .update(PatchCriteriaDto.fromDomain(patchCriteria).toJson())
          .eq('id', id)
          .select();
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

  Future<FailureOrResult<Chunk<Criteria>>> getPartnerCriteriasWithMark(
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

  Future<FailureOrResult<Map<Criteria, List<CriteriaCorrelation>>>>
      getCriteriasCorrelation() async {
    return await makeErrorHandledCallback(() async {
      final List<dynamic> response =
          await supabase.rpc('get_criteria_correlations', params: {
        'p_user_id': supabase.auth.currentUser!.id,
      });

      final criterias = response
          .map((item) => CriteriasCorrelationDto.fromJson(item))
          .expand(
            (item) => [
              (
                criteria: Criteria(
                  id: item.criteriaId1,
                  name: item.criteriaName1,
                ),
                correlation: CriteriaCorrelation(
                  criteria: Criteria(
                    id: item.criteriaId2,
                    name: item.criteriaName2,
                  ),
                  occurrences: item.occurrences,
                  correlation: item.correlation,
                ),
              ),
              (
                criteria: Criteria(
                  id: item.criteriaId2,
                  name: item.criteriaName2,
                ),
                correlation: CriteriaCorrelation(
                  criteria: Criteria(
                    id: item.criteriaId1,
                    name: item.criteriaName1,
                  ),
                  occurrences: item.occurrences,
                  correlation: item.correlation,
                ),
              ),
            ],
          )
          .toList()
        ..sort((a, b) => a.criteria.id.compareTo(b.criteria.id));

      final result = criterias.groupBy((item) => item.criteria).map(
            (key, value) => MapEntry(
              key,
              value.map((item) => item.correlation).toList()
                ..sort((a, b) => a.criteria.id.compareTo(b.criteria.id)),
            ),
          );

      return FailureOrResult.success(result);
    });
  }
}
