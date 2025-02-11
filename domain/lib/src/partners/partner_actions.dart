import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class CreatePartnerAction extends Action {
  final NewPartner partner;

  CreatePartnerAction(this.partner);
}

class DeletePartnerAction extends Action {}

class UpdatePartnerAction extends Action {
  final PatchPartner partner;

  UpdatePartnerAction(this.partner);
}
