import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_together_app/features/make_event/presentation/blocs/maps_location_cubit/maps_location_cubit.dart';
import '../../authentication/di/authentication_di.dart';
import '../../authentication/presentation/bloc/auth_bloc/auth_bloc.dart';

import '../di/home_di.dart';
import 'bloc/nav_bar_cubit/nav_bar_cubit.dart';
import 'bloc/nav_bar_style_cubit/nav_bar_style_cubit.dart';
import 'widgets/custom_bottom_nav_bar.dart';
import 'widgets/nav_bar_item.dart';

enum HomeScreen {
  events_overview,
  notifications_overview,
  make_event_HomeScreen,
  chats_overview,
  profile_overview,
}

class HomeScreenWidget extends StatelessWidget {
  static const String route = "/home_HomeScreen";

  const HomeScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeScreenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(237, 231, 246, 1),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => homeGetIt<NavBarCubit>(),
          ),
          BlocProvider(
            create: (_) => homeGetIt<NavBarStyleCubit>(),
          ),
          BlocProvider<AuthBloc>(
            create: (_) => getIt<AuthBloc>(),
          ),
          BlocProvider<MapsLocationCubit>(
            create: (_) => getIt<MapsLocationCubit>(),
          ),
        ],
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Container(
                  height: HomeScreenSize.height - CustomNavBar.hight,
                  child: BlocBuilder<NavBarCubit, NavBarState>(
                    builder: (context, state) => state.screen,
                  ),
                ),
                CustomNavBar(screenSize: HomeScreenSize),
              ],
            ),
            NavBarMiddleItem(screen: HomeScreen.make_event_HomeScreen),
          ],
        ),
      ),
    );
  }
}
