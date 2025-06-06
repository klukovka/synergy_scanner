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
          Endpoint(
            GetTableItems<Partner, CriteriaTablePointer>(
              partnersRepository.getPartnersWithMark,
              store.getFilter(
                modifier: LockById<Criteria>(
                  FilterBy.criteriaId,
                ),
              ),
            ),
          ).call,
          Endpoint(
            GetTableItems<Partner, AnalyticsTablePointer>(
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
              criteriasRepository.getPartnerCriteriasWithMark,
              store.getFilter(
                modifier: LockById<Partner>(
                  FilterBy.partnerId,
                ),
              ),
            ),
          ).call,
        ]);
}
