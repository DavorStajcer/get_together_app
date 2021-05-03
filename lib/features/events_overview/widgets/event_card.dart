import 'package:flutter/material.dart';
import 'package:get_together_app/features/events_overview/widgets/event_admin.dart';

class EventCard extends StatelessWidget {
  const EventCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: EventAdmin(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Some text that is written overhere Some text that is written overhere Some text that is written overhere Some text that is written overhereSome text that is written overhereSome text that is written overhereSome text that is written overhereSome text that is written overhere Some text that is written overhere Some text that is written overhere Some text that is written overhere Some text that is written overhere Some text that is written overhereSome text that is written overhereSome text that is written overhereSome text that is written overhereSome text that is written overhere",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13),
                  softWrap: true,
                  maxLines: 5,
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(),
                  ),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                          (states) {
                            if (states.contains(MaterialState.pressed))
                              return Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.7);
                            return Theme.of(context).primaryColor;
                          },
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Find out more",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
