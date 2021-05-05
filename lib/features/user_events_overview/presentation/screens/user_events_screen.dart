import 'package:flutter/material.dart';
import 'package:get_together_app/core/widgets/get_together_title.dart';
import 'package:get_together_app/core/widgets/event_card.dart';

class UserEventsScreen extends StatelessWidget {
  static const route = "/user_events_screen";
  const UserEventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: screenSize.height * 0.2,
              alignment: Alignment.topCenter,
              child: GetTogetherTitle(
                textColor: Theme.of(context).primaryColor,
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.15),
                child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return Container(
                      height: screenSize.width * 0.7,
                      child: EventCard(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
