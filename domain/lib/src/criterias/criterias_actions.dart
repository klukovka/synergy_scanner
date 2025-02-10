import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class CreateCriteriaAction extends Action {
  final NewCriteria criteria;

  CreateCriteriaAction(this.criteria);
}
