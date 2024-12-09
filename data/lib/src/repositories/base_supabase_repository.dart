import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseSupabaseRepository {
  final supabase = Supabase.instance.client;

  Future<FailureOrResult<T>> makeErrorHandledCallback<T>(
    Future<FailureOrResult<T>> Function() callback,
  ) async {
    try {
      return await callback();
    } on StorageException catch (error) {
      return FailureOrResult.failure(
        code: error.statusCode ?? '500',
        message: error.message,
      );
    } on AuthApiException catch (error) {
      return FailureOrResult.failure(
        code: error.statusCode ?? '500',
        message: error.message,
      );
    } on AuthPKCEGrantCodeExchangeError catch (error) {
      return FailureOrResult.failure(
        code: error.statusCode ?? '500',
        message: error.message,
      );
    } on AuthRetryableFetchException catch (error) {
      return FailureOrResult.failure(
        code: error.statusCode ?? '500',
        message: error.message,
      );
    } on AuthSessionMissingException catch (error) {
      return FailureOrResult.failure(
        code: error.statusCode ?? '500',
        message: error.message,
      );
    } on AuthUnknownException catch (error) {
      return FailureOrResult.failure(
        code: error.statusCode ?? '500',
        message: error.message,
      );
    } on AuthWeakPasswordException catch (error) {
      return FailureOrResult.failure(
        code: error.statusCode ?? '500',
        message: error.message,
      );
    } on AuthException catch (error) {
      return FailureOrResult.failure(
        code: error.statusCode ?? '500',
        message: error.message,
      );
    } on PostgrestException catch (error) {
      return FailureOrResult.failure(
        code: error.code ?? '500',
        message: error.message,
      );
    } on RealtimeSubscribeException catch (error) {
      return FailureOrResult.failure(
        code: error.status.name,
        message: error.details?.toString() ?? '',
      );
    } catch (e) {
      return FailureOrResult.failure(code: '500', message: 'Unexpected error');
    }
  }

  Future<List<Map<String, dynamic>>> getPaginatedResponse(
    PostgrestTransformBuilder<List<Map<String, dynamic>>> query,
    Filter filter,
  ) async =>
      await query.range(
        filter.page * filter.size,
        (filter.page + 1) * filter.size - 1,
      );
}
