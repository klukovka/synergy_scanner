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
        switch (filter.sortBy) {
          SortBy.coefficient => query.order(
              'coefficient',
              ascending: ascending,
            ),
          _ => query.order('name', ascending: ascending),
        },
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
