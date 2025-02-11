import 'package:clean_redux/clean_redux.dart';
import 'package:data/src/dtos/criterias/criteria_dto.dart';
import 'package:data/src/dtos/criterias/new_criteria_dto.dart';
import 'package:data/src/repositories/base_supabase_repository.dart';
import 'package:domain/domain.dart';

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
      var query = supabase
          .from('criterias')
          .select()
          .eq('user_id', supabase.auth.currentUser!.id);

      if (filter.search.isNotEmpty) {
        query = query.ilike('name', '%${filter.search}%');
      }

      final fullCount = (await query.count()).count;

      final ascending = filter.direction == Direction.asc;

      final result = await getPaginatedResponse(
        query.order(
            switch (filter.sortBy) {
              SortBy.coefficient => 'coefficient',
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

  Future<FailureOrResult<Chunk<Criteria>>> getPartnerCriteriasWithMarks(
    Filter filter,
  ) async {
    return await makeErrorHandledCallback(() async {
      var query = supabase
          .from('criterias')
          .select('*, marks(*)')
          .eq('user_id', supabase.auth.currentUser!.id)
          .eq('marks.partner_id', filter.filters[FilterBy.partnerId]!.first);

      if (filter.search.isNotEmpty) {
        query = query.ilike('name', '%${filter.search}%');
      }

      final fullCount = (await query.count()).count;

      final ascending = filter.direction == Direction.asc;

      final result = await getPaginatedResponse(
        query.order(
            switch (filter.sortBy) {
              SortBy.coefficient => 'coefficient',
              SortBy.mark => 'marks.mark',
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

// SELECT c.id, c.name, c.coefficient, m.id AS mark_id, m.mark AS mark, m.partner_id
// FROM public.marks m
// FULL OUTER JOIN public.criterias c ON m.criteria_id = c.id
// AND m.partner_id = 16
// WHERE c.user_id = '889f8c5e-afb1-4617-b7bc-25c93af3aab5';
