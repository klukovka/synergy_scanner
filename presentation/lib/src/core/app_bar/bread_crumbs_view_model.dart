import 'package:domain/domain.dart';
import 'package:presentation/src/core/base_view_model.dart';

class BreadCrumbsViewModel extends BaseViewModel {
  final List<Destination> currentRoute;

  BreadCrumbsViewModel(
    super.store,
  ) : currentRoute = store.state.navigationState.currentRoute.toList();

  bool get isOnePage =>
      currentRoute.where((element) => element.canBePartOfRoute).length == 1;

  bool isCurrent(Destination destination) =>
      currentRoute.lastWhere((destination) => destination.canBePartOfRoute) ==
      destination;

  void onClosed(Destination destination) {
    final count = currentRoute.where((x) => x.canBePartOfRoute).length -
        currentRoute.lastIndexOf(destination) -
        1;
    store.dispatch(ClosePageAction(count: count));
  }

  @override
  List<Object?> get props => [currentRoute];
}
