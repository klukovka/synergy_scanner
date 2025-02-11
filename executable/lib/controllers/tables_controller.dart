import 'package:clean_redux/clean_redux.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:executable/core/filter_extensions.dart';
import 'package:redux/redux.dart';

class TablesController extends Controller {
  TablesController(
    Store<AppState> Function() store,
    PartnersSupabaseRepository partnersRepository,
    CriteriasSupabaseRepository criteriasRepository,
  ) : super([
          ///
          /// Partners
          ///
          Endpoint(
            GetTableItems<Partner, GeneralTablePointer>(
              partnersRepository.getPartners,
              store.getFilter(),
            ),
          ).call,

          ///
          /// Criterias
          ///
          Endpoint(
            GetTableItems<Criteria, GeneralTablePointer>(
              criteriasRepository.getCriterias,
              store.getFilter(),
            ),
          ).call,
          Endpoint(
            GetTableItems<Criteria, PartnerTablePointer>(
              criteriasRepository.getPartnerCriteriasWithMarks,
              store.getFilter(
                modifier: LockById<Partner>(
                  FilterBy.partnerId,
                ),
              ),
            ),
          ).call,
        ]);
}
