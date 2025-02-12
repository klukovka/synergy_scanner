import 'package:clean_redux/clean_redux.dart';
import 'package:domain/domain.dart';

class SetMarkLoading extends Action {
  final bool isLoading;

  SetMarkLoading(this.isLoading);
}

class CreateMarkAction extends Action {
  final Criteria criteria;
  final Partner partner;
  final int mark;

  CreateMarkAction({
    required this.criteria,
    required this.mark,
    required this.partner,
  });
}

class UpdateMarkAction extends Action {
  final int id;
  final Criteria criteria;
  final Partner partner;
  final int mark;

  UpdateMarkAction({
    required this.id,
    required this.criteria,
    required this.partner,
    required this.mark,
  });
}
