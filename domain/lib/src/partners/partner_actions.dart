import 'package:clean_redux/clean_redux.dart';
import 'package:domain/src/partners/entities/new_partner.dart';

class CreatePartnerAction extends Action {
  final NewPartner partner;

  CreatePartnerAction(this.partner);
}
