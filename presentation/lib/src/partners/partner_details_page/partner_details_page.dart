import 'package:clean_redux/clean_redux.dart' hide State;
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:presentation/src/core/app_bar/mobile_app_bar.dart';
import 'package:presentation/src/core/tables/table_view_model.dart';
import 'package:presentation/src/criterias/criterias_page/widgets/criteria_card.dart';
import 'package:presentation/src/criterias/criterias_page/widgets/criterias_table.dart';
import 'package:presentation/src/general/rating/rating_field.dart';
import 'package:presentation/src/partners/partner_details_page/widgets/partner_details_header.dart';
import 'package:presentation/src/partners/partner_details_page/widgets/partners_criterias_table_action_bar.dart';
import 'package:redux/redux.dart';

class PartnerDetailsPage extends StatefulWidget {
  const PartnerDetailsPage({super.key});

  @override
  State<PartnerDetailsPage> createState() => _PartnerDetailsPageState();
}

class _PartnerDetailsPageState extends State<PartnerDetailsPage> {
  final _fbKey = GlobalKey<FormBuilderState>();
  Criteria? _lastChangedCriteria;

  FormBuilderState? get _fbState => _fbKey.currentState;

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      converter: _ViewModel.new,
      onInit: (Store<AppState> store) => _ViewModel(store).onInit(),
      onWillChange: (previousViewModel, newViewModel) {
        if (previousViewModel?.partnerFailure != newViewModel.partnerFailure) {
          newViewModel.handleUnexpectedError(
            message: newViewModel.partnerFailure?.message,
            shouldCloseCurrentPage: true,
          );
        }

        if (previousViewModel?.marksFailure != newViewModel.marksFailure &&
            _lastChangedCriteria != null) {
          _fbState?.patchValue({
            'mark_${_lastChangedCriteria?.id}':
                _lastChangedCriteria?.mark?.mark,
          });
          _lastChangedCriteria = null;
        } else if (previousViewModel?.isMarkLoading !=
                newViewModel.isMarkLoading &&
            _lastChangedCriteria != null &&
            !newViewModel.isMarkLoading) {
          final mark = newViewModel.items
              .firstWhereOrNull((item) => item.id == _lastChangedCriteria?.id)
              ?.mark;
          _fbState?.patchValue({
            'mark_${_lastChangedCriteria?.id}': mark?.mark,
          });
          _lastChangedCriteria = null;
        }
      },
      builder: (context, viewModel) => FormBuilder(
        key: _fbKey,
        child: Scaffold(
          appBar: const MobileAppBar(),
          body: Column(
            children: [
              if (viewModel.partner != null)
                PartnerDetailsHeader(partner: viewModel.partner!),
              const CriteriasTableActionBar(),
              Expanded(
                child: CriteriasTable<PartnerTablePointer>(
                  itemBuilder: (context, criteria) => CriteriaCard(
                    key: ValueKey(criteria.id),
                    criteria: criteria,
                    subtitle: RatingField(
                      name: 'mark_${criteria.id}',
                      initialValue: criteria.mark?.mark.toInt(),
                      starIconSize: 32,
                      enabled: !viewModel.isMarkLoading,
                      onChanged: (value) {
                        _lastChangedCriteria = criteria;
                        viewModel.onMarkChanged(
                          criteriaId: criteria.id,
                          mark: criteria.mark,
                          value: value ?? 0,
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ViewModel extends TableViewModel<Criteria, PartnerTablePointer> {
  final Failure? partnerFailure;
  final Partner? partner;
  final bool isMarkLoading;
  final Failure? marksFailure;

  _ViewModel(super.store)
      : partnerFailure = store.state.partnersState.failure,
        partner = store.state.tablesState.getTables<Partner>().selectedItem,
        isMarkLoading = store.state.marksState.isLoading,
        marksFailure = store.state.marksState.failure;

  void onInit() {
    store.dispatch(
      DownloadTableItemsAction<Criteria, PartnerTablePointer>(
        append: false,
        clear: true,
      ),
    );
  }

  void onMarkChanged({
    required int criteriaId,
    required Mark? mark,
    required int value,
  }) {
    if (mark == null) {
      store.dispatch(
        CreateMarkAction(
          criteriaId: criteriaId,
          mark: value,
        ),
      );
    } else {
      store.dispatch(
        UpdateMarkAction(
          PatchMark(
            mark: value,
            criteriaId: criteriaId,
            partnerId: partner!.id,
          ),
          mark.id,
        ),
      );
    }
  }

  @override
  List<Object?> get props => [
        ...super.props,
        partnerFailure,
        partner,
        isMarkLoading,
        marksFailure,
      ];
}
