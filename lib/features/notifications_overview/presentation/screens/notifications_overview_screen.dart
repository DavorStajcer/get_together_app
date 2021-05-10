import 'package:flutter/material.dart';
import 'package:get_together_app/core/widgets/get_together_title.dart';

class NotificationsOverviewScreen extends StatelessWidget {
  const NotificationsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Column(
      children: [
        Container(
          height: screenSize.height * 0.15,
          alignment: Alignment.topCenter,
          child: GetTogetherTitle(
            textColor: Theme.of(context).primaryColor,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 15,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    leading: Container(
                      height: double.infinity,
                      child: Icon(
                        Icons.announcement_outlined,
                      ),
                    ),
                    title: Text("You have received a new friend request"),
                    subtitle: Text("DADSADASDAS"),
                  ),
                  Divider(),
                ],
              );
            },
          ),
        ),
      ],
    ));
  }
}
