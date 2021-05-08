import "package:flutter/material.dart";
import 'package:get_together_app/features/chats_overview/util/left_message_clipper.dart';

class MessageBubbleLeft extends StatelessWidget {
  const MessageBubbleLeft({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: ClipPath(
            clipper: LeftMessageClipper(20),
            child: Container(
              color: Theme.of(context).primaryColor.withOpacity(0.8),
              width: double.infinity,
              /*   padding:
                  EdgeInsets.only(bottom: 30, right: 30, top: 10, left: 10), */
              padding:
                  EdgeInsets.only(left: 30, bottom: 30, top: 10, right: 10),
              child: Text(
                "Hello ! Its me. Daca the dacmen. Wačju bin ap tu ?",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(
            width: double.infinity,
          ),
        ),
      ],
    );
  }
}
