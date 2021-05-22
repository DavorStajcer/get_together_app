import 'package:flutter/material.dart';
import 'package:get_together_app/core/widgets/get_together_title.dart';
import 'package:get_together_app/core/widgets/event_card/event_card.dart';
import 'package:get_together_app/features/events_overview/domain/entities/event.dart';
import 'package:get_together_app/features/make_event/presentation/blocs/event_card_order_cubit/event_card_order_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
                      child: EventCard(
                        event: Event(
                          eventId: "eventId",
                          eventType: EventType.food,
                          dateString: "1.1.1111",
                          timeString: "11:11",
                          location: LatLng(37, 36),
                          adminId: "someId",
                          adminUsername: "Black",
                          adminImageUrl:
                              "https://api.time.com/wp-content/uploads/2017/12/terry-crews-person-of-year-2017-time-magazine-facebook-1.jpg?quality=85",
                          adminRating: -1,
                          numberOfPeople: 2,
                          description: "some event i dunno",
                          peopleImageUrls: {},
                        ),
                        color: Colors.white,
                        elevation: 1,
                      ),
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
