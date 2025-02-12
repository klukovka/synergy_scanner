import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class CreateCriteriaAction extends Action {
  final NewCriteria criteria;

  CreateCriteriaAction(this.criteria);
}

class DeleteCriteriaAction extends Action {}

class UpdateCriteriaAction extends Action {
  final PatchCriteria criteria;

  UpdateCriteriaAction(this.criteria);
}
