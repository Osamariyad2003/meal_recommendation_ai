import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../core/utils/assets.dart';
import '../../../favourite/presentation/screens/favourite_screen.dart';
import '../../../home/persentation/screens/home_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../sidebar/presentation/screens/side_bar_screen.dart';
import '../blocs/layout_bloc.dart';
import '../blocs/layout_event.dart';
import '../blocs/layout_state.dart';
import '../widgets/custom_navigation_destination.dart';

class LayoutView extends StatelessWidget {
   LayoutView({super.key});


  @override
  Widget build(BuildContext context) {
    return
        BlocBuilder<LayoutBloc, LayoutState>(
          buildWhen: (previous, current) =>
              previous.bottomNavIndex != current.bottomNavIndex,
          builder: (context, state) => Scaffold(
            drawer: SideMenu(),
            body: [
              // (Don't use scaffold again in the following widgets)
               HomeScreen(),
               FavoriteScreen(),
               ProfileScreen(),
            ][state.bottomNavIndex],
            bottomNavigationBar: NavigationBar(
              backgroundColor: Colors.white,
              elevation: 0,
              indicatorColor: Colors.transparent,
              animationDuration: const Duration(milliseconds: 500),
              destinations: const [
                CustomNavigationDestination(
                  icon: Assets.iconsHomeIcon,
                  selectedIcon: Assets.iconsWhiteHomeIcon,
                ),
                CustomNavigationDestination(
                  icon: Assets.iconsHeartIcon,
                  selectedIcon: Assets.iconsWhiteHeartIcon,
                ),
                CustomNavigationDestination(
                  icon: Assets.iconsProfileIcon,
                  selectedIcon: Assets.iconsWhiteProfileIcon,
                ),
              ],
              selectedIndex: state.bottomNavIndex,
              onDestinationSelected: (index) =>
                  context.read<LayoutBloc>().add(ChangeBottomNavIndex(index)),
            ),
          ));
  }
}
