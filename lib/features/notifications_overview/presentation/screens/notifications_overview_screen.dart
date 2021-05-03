import 'package:flutter/material.dart';

class NotificationsOverviewScreen extends StatelessWidget {
  const NotificationsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Column(
      children: [
        Container(
          height: screenSize.height * 0.2,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 15),
          child: Text(
            "GeTogether",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 35,
                fontWeight: FontWeight.bold),
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
