import 'package:clean_redux/clean_redux.dart' hide State;
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:presentation/src/core/app_bar/mobile_app_bar.dart';
import 'package:presentation/src/core/tables/table_view_model.dart';
import 'package:presentation/src/criterias/criterias_page/widgets/criteria_card.dart';
import 'package:presentation/src/criterias/criterias_page/widgets/criterias_table.dart';
import 'package:presentation/src/general/rating/rating_field.dart';
import 'package:presentation/src/partners/partner_details_page/widgets/partner_details_header.dart';
import 'package:presentation/src/partners/partner_details_page/widgets/partners_criterias_table_action_bar.dart';

class PartnerDetailsPage extends StatefulWidget {
  const PartnerDetailsPage({super.key});

  @override
  State<PartnerDetailsPage> createState() => _PartnerDetailsPageState();
}

class _PartnerDetailsPageState extends State<PartnerDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      converter: _ViewModel.new,
      onInitialBuild: (viewModel) => viewModel.onInit(),
      onWillChange: (previousViewModel, newViewModel) {
        if (previousViewModel?.partnerFailure != newViewModel.partnerFailure) {
          newViewModel.handleUnexpectedError(
            message: newViewModel.partnerFailure?.message,
            shouldCloseCurrentPage: true,
          );
        }
      },
      builder: (context, viewModel) => Scaffold(
        appBar: const MobileAppBar(),
        body: Column(
          children: [
            const PartnerDetailsHeader(),
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
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ViewModel extends TableViewModel<Criteria, PartnerTablePointer> {
  final Failure? partnerFailure;

  _ViewModel(super.store) : partnerFailure = store.state.partnersState.failure;

  void onInit() {
    store.dispatch(
      DownloadTableItemsAction<Criteria, PartnerTablePointer>(
        append: false,
        clear: true,
      ),
    );
  }

  @override
  List<Object?> get props => [...super.props, partnerFailure];
}
