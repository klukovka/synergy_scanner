import 'package:clean_redux/clean_redux.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:redux/redux.dart';

class MarksController extends Controller {
  MarksController(
    Store<AppState> Function() store,
    MarksSupabaseRepository marksRepository,
  ) : super([
          Endpoint(
            CreateMark(
              marksRepository.createMark,
            ),
          ).call,
          Endpoint(
            UpdateMark(
              marksRepository.updateMark,
            ),
          ).call,
        ]);
}
