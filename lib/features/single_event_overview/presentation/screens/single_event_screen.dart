import 'package:flutter/material.dart';
import 'package:get_together_app/features/single_event_overview/presentation/widgets/admin_details.dart';
import 'package:get_together_app/features/single_event_overview/presentation/widgets/description.dart';
import 'package:get_together_app/features/single_event_overview/presentation/widgets/join_button.dart';
import 'package:get_together_app/features/single_event_overview/presentation/widgets/people_comming..dart';
import 'package:get_together_app/features/single_event_overview/presentation/widgets/single_event_maps.dart';

class SingleEventScreen extends StatelessWidget {
  static const route = "/single_event_screen";
  const SingleEventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(237, 231, 246, 1),
      body: Column(
        children: [
          Flexible(
            flex: 4,
            child: SingleEventMaps(),
          ),
          Flexible(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 3,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: Text(
                                "Date/Time",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 6,
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                "20.2.2020. / 15:30",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: AdminDetails(),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Description(),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: PoepleComming(),
                  ),
                  //TODO: build this if current uid == admin id
                  //TODO: change text to "Leave event" if the user is allready joined
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: JoinButton(),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
