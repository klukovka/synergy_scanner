import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:presentation/src/core/base_view_model.dart';
import 'package:presentation/src/partners/partner_details_page/widgets/partner_details_options_button.dart';
import 'package:presentation/src/partners/widgets/partner_card.dart';

class PartnerDetailsHeader extends StatelessWidget {
  const PartnerDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      distinct: true,
      converter: _ViewModel.new,
      builder: (context, viewModel) {
        final partner = viewModel.partner;
        if (partner == null) return const SizedBox.shrink();
        return PartnerCard(
          partner: partner,
          trailing: const PartnerDetailsOptionsButton(),
        );
      },
    );
  }
}

class _ViewModel extends BaseViewModel {
  final Partner? partner;

  _ViewModel(super.store)
      : partner = store.state.tablesState.getTables<Partner>().selectedItem;

  @override
  List<Object?> get props => [partner];
}
