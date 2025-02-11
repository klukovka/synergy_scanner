import 'package:clean_redux/clean_redux.dart';
import 'package:data/src/dtos/marks/mark_dto.dart';
import 'package:data/src/dtos/marks/new_mark_dto.dart';
import 'package:data/src/dtos/marks/patch_mark_dto.dart';
import 'package:data/src/repositories/base_supabase_repository.dart';
import 'package:domain/domain.dart';

class MarksSupabaseRepository extends BaseSupabaseRepository {
  Future<FailureOrResult<int>> createMark(NewMark newMark) async {
    return await makeErrorHandledCallback(() async {
      final result = await supabase
          .from('marks')
          .insert(NewMarkDto.fromDomain(newMark).toJson())
          .select();
      final id = result.first['id'] as int;

      return FailureOrResult.success(id);
    });
  }

  Future<FailureOrResult<Mark>> updateMark(int id, PatchMark patchMark) async {
    return await makeErrorHandledCallback(() async {
      final result = await supabase
          .from('marks')
          .update(PatchMarkDto.fromDomain(patchMark).toJson())
          .eq('id', id)
          .select();
      return FailureOrResult.success(MarkDto.fromJson(result.first).toDomain());
    });
  }
}
