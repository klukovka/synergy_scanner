import 'package:clean_redux/clean_redux.dart' hide State;
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:presentation/src/core/app_bar/mobile_app_bar.dart';
import 'package:presentation/src/core/tables/table_view_model.dart';
import 'package:presentation/src/criterias/criteria_details_page/widgets/criteria_details_header.dart';
import 'package:presentation/src/criterias/criteria_details_page/widgets/criteria_partners_table_action_bar.dart';
import 'package:presentation/src/general/loaders/styled_loader/styled_loader.dart';
import 'package:presentation/src/general/rating/rating_field.dart';
import 'package:presentation/src/partners/partners_page/widgets/partners_table.dart';
import 'package:presentation/src/partners/widgets/partner_card.dart';
import 'package:redux/redux.dart';

class CriteriaDetailsPage extends StatefulWidget {
  const CriteriaDetailsPage({super.key});

  @override
  State<CriteriaDetailsPage> createState() => _CriteriaDetailsPageState();
}

class _CriteriaDetailsPageState extends State<CriteriaDetailsPage> {
  final _fbKey = GlobalKey<FormBuilderState>();
  Partner? _lastChangedPartner;

  FormBuilderState? get _fbState => _fbKey.currentState;

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      converter: _ViewModel.new,
      onInit: (Store<AppState> store) => _ViewModel(store).onInit(),
      onWillChange: (previousViewModel, newViewModel) {
        if (previousViewModel?.criteriaFailure !=
            newViewModel.criteriaFailure) {
          newViewModel.handleUnexpectedError(
            message: newViewModel.criteriaFailure?.message,
          );
        }

        if (previousViewModel?.marksFailure != newViewModel.marksFailure &&
            _lastChangedPartner != null) {
          _fbState?.patchValue({
            'mark_${_lastChangedPartner?.id}': _lastChangedPartner?.mark?.mark,
          });
          _lastChangedPartner = null;
          newViewModel.handleUnexpectedError(
            message: newViewModel.marksFailure?.message,
            shouldCloseCurrentPage: true,
          );
        } else if (previousViewModel?.isMarkLoading !=
                newViewModel.isMarkLoading &&
            _lastChangedPartner != null &&
            !newViewModel.isMarkLoading) {
          final mark = newViewModel.items
              .firstWhereOrNull((item) => item.id == _lastChangedPartner?.id)
              ?.mark;
          _fbState?.patchValue({
            'mark_${_lastChangedPartner?.id}': mark?.mark,
          });
          _lastChangedPartner = null;
        }

        if (previousViewModel?.criteria != null &&
            newViewModel.criteria == null) {
          newViewModel.close();
        }
      },
      builder: (context, viewModel) => FormBuilder(
        key: _fbKey,
        child: Scaffold(
          appBar: const MobileAppBar(),
          body: viewModel.isDeleteInProgress
              ? const Center(child: StyledLoader.primary(size: 32))
              : Column(
                  children: [
                    if (viewModel.criteria != null)
                      CriteriaDetailsHeader(criteria: viewModel.criteria!),
                    const CriteriaPartnersTableActionBar(),
                    Expanded(
                      child: PartnersTable<CriteriaTablePointer>(
                        itemBuilder: (context, partner) => PartnerCard(
                          key: ValueKey(partner.id),
                          partner: partner,
                          subtitle: RatingField(
                            name: 'mark_${partner.id}',
                            initialValue: partner.mark?.mark.toInt(),
                            starIconSize: 32,
                            enabled: !viewModel.isMarkLoading &&
                                _lastChangedPartner == null,
                            onChanged: (value) {
                              if (_lastChangedPartner != null) return;
                              setState(() {
                                _lastChangedPartner = partner;
                              });
                              viewModel.onMarkChanged(
                                partner: partner,
                                mark: partner.mark,
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

class _ViewModel extends TableViewModel<Partner, CriteriaTablePointer> {
  final Failure? criteriaFailure;
  final Criteria? criteria;
  final bool isMarkLoading;
  final Failure? marksFailure;
  final bool isDeleteInProgress;

  static Criteria? getCriteria(Store<AppState> store) =>
      store.state.tablesState.getTables<Criteria>().selectedItem;

  _ViewModel(super.store)
      : criteriaFailure = store.state.criteriasState.failure,
        criteria = getCriteria(store),
        isMarkLoading = store.state.marksState.isLoading,
        marksFailure = store.state.marksState.failure,
        isDeleteInProgress = !store.state.tablesState
            .getTable<Criteria, GeneralTablePointer>()
            .items
            .any((item) => item.id == getCriteria(store)?.id);

  void onInit() {
    store.dispatch(
      DownloadTableItemsAction<Partner, CriteriaTablePointer>(
        append: false,
        clear: true,
      ),
    );
  }

  void onMarkChanged({
    required Partner partner,
    required Mark? mark,
    required int value,
  }) {
    if (mark == null) {
      store.dispatch(
        CreateMarkAction(
          partner: partner,
          mark: value,
          criteria: criteria!,
        ),
      );
      return;
    }
    store.dispatch(
      UpdateMarkAction(
        mark: value,
        partner: partner,
        criteria: criteria!,
        id: mark.id,
      ),
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        criteriaFailure,
        criteria,
        isMarkLoading,
        marksFailure,
        isDeleteInProgress,
      ];
}
