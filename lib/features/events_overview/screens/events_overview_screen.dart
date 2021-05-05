import 'package:flutter/material.dart';
import 'package:get_together_app/core/widgets/event_card.dart';
import 'package:get_together_app/features/events_overview/widgets/maps_view.dart';
import 'package:get_together_app/features/home/presentation/widgets/nav_bar_item.dart';

class EventsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: MapsView(),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
                bottom: NavBarMiddleItem.radius * 1.5,
                top: NavBarMiddleItem.radius / 2),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: double.infinity,
                  width: 250,
                  child: EventCard(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
