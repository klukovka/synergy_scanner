import 'package:domain/domain.dart';
import 'package:presentation/src/core/app_bar/bread_crumbs_view_model.dart';

class AppBarViewModel extends BreadCrumbsViewModel {
  final String Function(Destination destination) getLabel;

  AppBarViewModel(
    super.store, {
    required this.getLabel,
  });

  String get penultimateLabel => currentRoute.length > 1
      ? getLabel(currentRoute[currentRoute.length - 2])
      : '';

  @override
  List<Object?> get props => [currentRoute, getLabel];
}
