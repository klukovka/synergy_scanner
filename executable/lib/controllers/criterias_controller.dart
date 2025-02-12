import 'package:clean_redux/clean_redux.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:redux/redux.dart';

class CriteriasController extends Controller {
  CriteriasController(
    Store<AppState> Function() store,
    CriteriasSupabaseRepository criteriasRepository,
  ) : super([
          Endpoint(
            CreateCriteria(criteriasRepository.createCriteria),
          ).call,
          Endpoint(
            GetCriteriaDetails(criteriasRepository.getCriteriaDetails),
          ).call,
          Endpoint(
            UpdateCriteria(
              criteriasRepository.updateCriteria,
              () => store()
                  .state
                  .tablesState
                  .getTables<Criteria>()
                  .selectedItemId!,
            ),
          ).call,
          Endpoint(
            DeleteCriteria(
              criteriasRepository.deleteCriteria,
              () =>
                  store().state.tablesState.getTables<Criteria>().selectedItem!,
            ),
          ).call,
        ]);
}
