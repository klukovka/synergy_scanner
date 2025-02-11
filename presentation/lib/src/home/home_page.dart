import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:presentation/src/analytics/analytics_page/analytics_page.dart';
import 'package:presentation/src/core/base_view_model.dart';
import 'package:presentation/src/criterias/create_criteria_page/create_criteria_page.dart';
import 'package:presentation/src/criterias/criterias_filter_page/criterias_filter_page.dart';
import 'package:presentation/src/criterias/criterias_page/criterias_page.dart';
import 'package:presentation/src/home/home_page_tab_type.dart';
import 'package:presentation/src/home/widgets/bottom_navigation_bar_avatar.dart';
import 'package:presentation/src/navigation/fade_transition_page.dart';
import 'package:presentation/src/partners/create_edit_partner/create_partner/create_partner_page.dart';
import 'package:presentation/src/partners/create_edit_partner/edit_partner_page/edit_partner_page.dart';
import 'package:presentation/src/partners/partner_details_page/partner_details_page.dart';
import 'package:presentation/src/partners/partners_filter_page/partners_filter_page.dart';
import 'package:presentation/src/partners/partners_page/partners_page.dart';
import 'package:presentation/src/profile/profile_page/profile_page.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final _homePageKey = GlobalKey();
  DateTime _lastUpdate = DateTime.now();
  var _isInactive = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      _isInactive = false;
      if (DateTime.now().difference(_lastUpdate) > const Duration(minutes: 5)) {
        if (mounted) {
          _loadData(StoreProvider.of<AppState>(context, listen: false));
        }
      }
    } else if (state == AppLifecycleState.inactive && !_isInactive) {
      _isInactive = true;
      _lastUpdate = DateTime.now();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void _loadData(Store<AppState> store) {
    store.dispatch(const ReloadDataAction());
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomePageViewModel>(
      distinct: true,
      converter: HomePageViewModel.new,
      onInit: (store) {
        _loadData(store);
      },
      ignoreChange: (appState) {
        return appState.navigationState.currentRoute
                .contains(Destination.login) ||
            appState.currentUserState.user == null;
      },
      builder: (context, viewModel) {
        final page = Theme(
          data: Theme.of(context).copyWith(
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                for (final platfrom in TargetPlatform.values)
                  platfrom: const CupertinoPageTransitionsBuilder()
              },
            ),
          ),
          child: Builder(
            builder: (context) => Navigator(
              key: _homePageKey,
              onPopPage: (route, result) {
                if (viewModel.previousRoutes.isNotEmpty) {
                  viewModel.close();
                  return false;
                }
                return true;
              },
              transitionDelegate: const DefaultTransitionDelegate(),
              pages: viewModel.currentRoute
                  .expand<Page>(
                    (destination) => switch (destination) {
                      Destination.partners => [
                          const FadeTransitionPage(
                            key: ValueKey(Destination.partners),
                            child: PopScope(
                              canPop: !kIsWeb,
                              child: PartnersPage(),
                            ),
                          )
                        ],
                      Destination.criterias => [
                          const FadeTransitionPage(
                            key: ValueKey(Destination.criterias),
                            child: CriteriasPage(),
                          )
                        ],
                      Destination.analytics => const [
                          FadeTransitionPage(
                            key: ValueKey(Destination.analytics),
                            child: AnalyticsPage(),
                          )
                        ],
                      Destination.profile => const [
                          FadeTransitionPage(
                            key: ValueKey(Destination.profile),
                            child: ProfilePage(),
                          ),
                        ],
                      Destination.createPartner => const [
                          MaterialPage(
                            key: ValueKey(Destination.createPartner),
                            child: CreatePartnerPage(),
                          ),
                        ],
                      Destination.partnersFilters => const [
                          MaterialPage(
                            key: ValueKey(Destination.partnersFilters),
                            child: PartnersFilterPage(),
                          ),
                        ],
                      Destination.createCriteria => const [
                          MaterialPage(
                            key: ValueKey(Destination.createCriteria),
                            child: CreateCriteriaPage(),
                          ),
                        ],
                      Destination.criteriasFilters => const [
                          MaterialPage(
                            key: ValueKey(Destination.criteriasFilters),
                            child: CriteriasFilterPage<GeneralTablePointer>(
                              sortingOptions: [SortBy.name, SortBy.coefficient],
                            ),
                          ),
                        ],
                      Destination.partnerDetails => const [
                          MaterialPage(
                            key: ValueKey(Destination.partnerDetails),
                            child: PartnerDetailsPage(),
                          ),
                        ],
                      Destination.partnerCriteriasFilters => const [
                          MaterialPage(
                            key: ValueKey(Destination.partnerCriteriasFilters),
                            child: CriteriasFilterPage<PartnerTablePointer>(
                              sortingOptions: [
                                SortBy.name,
                                SortBy.coefficient,
                              ],
                            ),
                          ),
                        ],
                      Destination.editPartner => const [
                          MaterialPage(
                            key: ValueKey(Destination.editPartner),
                            child: EditPartnerPage(),
                          ),
                        ],
                      _ => [],
                    },
                  )
                  .toList(),
            ),
          ),
        );
        return Scaffold(
          body: page,
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) => viewModel.openTab(
              HomePageTabType.values[index].route,
            ),
            currentIndex: HomePageTabType.values
                    .firstWhereOrNull((item) =>
                        item.route == viewModel.currentRoute.firstOrNull())
                    ?.index ??
                0,
            items: HomePageTabType.values.map((item) {
              if (item == HomePageTabType.profile) {
                return BottomNavigationBarItem(
                  icon: BottomNavigationBarAvatar(
                    imageUrl: viewModel.user.avatarUrl,
                    isCurrent:
                        viewModel.isIconActive(HomePageTabType.profile.route),
                  ),
                  label: item.getDisplayText(context),
                );
              }
              return BottomNavigationBarItem(
                icon: Icon(item.inactiveIconData, size: 32),
                activeIcon: Icon(item.activeIconData, size: 32),
                label: item.getDisplayText(context),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class HomePageViewModel extends BaseViewModel {
  final Set<Destination> currentRoute;
  final List<Set<Destination>> previousRoutes;
  final User user;

  HomePageViewModel(super.store)
      : currentRoute = store.state.navigationState.currentRoute,
        previousRoutes = store.state.navigationState.previousRoutes,
        user = store.state.currentUserState.user!;

  void openTab(Destination destination) {
    if (currentRoute.first == destination) {
      store.dispatch(ReplaceRouteAction({destination}));
    } else {
      store.dispatch(ReturnRouteWithSpecifiedRootAction(destination));
    }
  }

  bool isIconActive(Destination destination) =>
      currentRoute.contains(destination);

  @override
  List<Object?> get props => [currentRoute, user, previousRoutes];
}
