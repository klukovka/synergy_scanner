import 'package:clean_redux/clean_redux.dart';

class SetMarkLoading extends Action {
  final bool isLoading;

  SetMarkLoading(this.isLoading);
}

class CreateMarkAction extends Action {
  final int criteriaId;
  final int mark;

  CreateMarkAction({
    required this.criteriaId,
    required this.mark,
  });
}
