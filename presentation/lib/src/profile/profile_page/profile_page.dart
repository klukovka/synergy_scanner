import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:localizations/localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:presentation/src/core/base_view_model.dart';
import 'package:presentation/src/general/tiles/navigation_tile.dart';
import 'package:presentation/src/profile/profile_page/widgets/profile_short_info_view.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.new,
      builder: (context, viewModel) {
        final tiles = <Widget>[
          NavigationTile(
            leading: Icon(MdiIcons.account),
            title: Text(context.strings.editProfile),
            onPressed: () => viewModel.openPage(Destination.editProfile),
          ),
          NavigationTile(
            leading: Icon(MdiIcons.key),
            title: Text(context.strings.changePassword),
            onPressed: () => viewModel.openPage(Destination.changePassword),
          ),
          NavigationTile(
            leading: const Icon(Icons.language),
            title: Text(context.strings.language),
            onPressed: () => viewModel.openPage(Destination.language),
          ),
          NavigationTile(
            leading: Icon(MdiIcons.themeLightDark),
            title: Text(context.strings.theme),
            onPressed: () => viewModel.openPage(Destination.theme),
          ),
        ];
        return SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: ProfileShortInfoView(
                    user: viewModel.user,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: Divider()),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList.separated(
                  itemBuilder: (context, index) => tiles[index],
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemCount: tiles.length,
                ),
              ),
              const SliverToBoxAdapter(child: Divider()),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                          onPressed: viewModel.logout,
                          icon: Icon(MdiIcons.exitToApp),
                          label: Text(context.strings.logout),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ViewModel extends BaseViewModel {
  final User? user;

  _ViewModel(super.store) : user = store.state.currentUserState.user;

  @override
  void logout() {
    store.dispatch(LogoutAction());
  }

  @override
  List<Object?> get props => [user];
}
