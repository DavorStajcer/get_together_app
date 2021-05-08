import "package:flutter/material.dart";
import 'package:get_together_app/features/chats_overview/util/right_message_clipper.dart';

class MessageBubbleRight extends StatelessWidget {
  const MessageBubbleRight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Container(),
        ),
        Flexible(
          flex: 2,
          child: ClipPath(
            clipper: RightMessageClipper(20),
            child: Container(
              color: Colors.white,
              width: double.infinity,
              padding:
                  EdgeInsets.only(bottom: 30, right: 30, top: 10, left: 10),
              child: Text(
                "Hello ! Its me. Daca the dacmen. Wačju bin ap tu ?",
                style: TextStyle(
                    fontSize: 13,
                    color: Theme.of(context).primaryColor.withOpacity(1)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
