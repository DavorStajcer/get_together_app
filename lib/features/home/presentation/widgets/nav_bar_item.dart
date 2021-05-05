import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_together_app/features/home/presentation/widgets/custom_nav_bar.dart';
import '../bloc/nav_bar_cubit/nav_bar_cubit.dart';

import '../bloc/nav_bar_style_cubit/nav_bar_style_cubit.dart';
import '../bloc/nav_bar_style_cubit/nav_bar_style_state.dart';
import '../screens/home_screen.dart';

class NavBarItem extends StatelessWidget {
  final HomeScreen screen;
  const NavBarItem({Key? key, required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarStyleCubit, NavBarStyleState>(
      builder: (context, state) {
        return IconButton(
          icon: Icon(
            _mapScreenToNavBarIcon(screen),
            size: state.itemsStyle[screen]!.iconSize,
            color: state.itemsStyle[screen]!.color,
          ),
          onPressed: () {
            BlocProvider.of<NavBarStyleCubit>(context).changeNavStyle(screen);
            BlocProvider.of<NavBarCubit>(context).changeScreen(screen);
          },
        );
      },
    );
  }
}

class NavBarMiddleItem extends StatelessWidget {
  static const double radius = 40;
  final HomeScreen screen;
  NavBarMiddleItem({required this.screen});

  Widget build(BuildContext context) {
    return BlocBuilder<NavBarStyleCubit, NavBarStyleState>(
      builder: (context, state) {
        return state.itemsStyle[screen] == NavItemPressed()
            ? SizedBox(
                height: NavBarMiddleItem.radius * 2,
                width: NavBarMiddleItem.radius * 2,
              )
            : Container(
                margin: EdgeInsets.only(bottom: CustomNavBar.hight - radius),
                height: NavBarMiddleItem.radius * 2,
                width: NavBarMiddleItem.radius * 2,
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    BlocProvider.of<NavBarStyleCubit>(context)
                        .changeNavStyle(screen);
                    BlocProvider.of<NavBarCubit>(context).changeScreen(screen);
                  },
                  child: Icon(_mapScreenToNavBarIcon(screen)),
                ),
              );
      },
    );
  }
}

IconData _mapScreenToNavBarIcon(HomeScreen screen) {
  switch (screen) {
    case HomeScreen.events_overview:
      return Icons.account_tree_outlined;

    case HomeScreen.notifications_overview:
      return Icons.wrap_text_sharp;

    case HomeScreen.make_event_HomeScreen:
      return Icons.adjust_rounded;

    case HomeScreen.chats_overview:
      return Icons.textsms;
    case HomeScreen.profile_overview:
      return Icons.accessibility_new_sharp;
    default:
      return Icons.account_tree_outlined;
  }
}
