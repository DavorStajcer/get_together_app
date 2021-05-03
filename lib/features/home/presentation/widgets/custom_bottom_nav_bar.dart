import 'package:flutter/material.dart';
import '../home_screen.dart';
import 'nav_bar_item.dart';

class CustomNavBar extends StatelessWidget {
  static const double hight = 75;
  final Size screenSize;
  const CustomNavBar({Key? key, required this.screenSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: screenSize.width,
      height: hight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavBarItem(
            screen: HomeScreen.events_overview,
          ),
          NavBarItem(
            screen: HomeScreen.notifications_overview,
          ),
          SizedBox(
            width: NavBarMiddleItem.radius,
          ),
          NavBarItem(
            screen: HomeScreen.chats_overview,
          ),
          NavBarItem(
            screen: HomeScreen.profile_overview,
          ),
        ],
      ),
    );
  }
}
