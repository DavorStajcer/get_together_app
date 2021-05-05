import 'package:flutter/material.dart';
import 'package:get_together_app/core/widgets/event_admin.dart';

class AdminDetails extends StatelessWidget {
  const AdminDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Text(
              "Admin",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(),
        ),
        Flexible(
          flex: 5,
          child: Center(
            child: EventAdmin(),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(),
        ),
      ],
    );
  }
}
