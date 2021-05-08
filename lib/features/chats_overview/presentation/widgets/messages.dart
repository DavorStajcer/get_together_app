import 'package:flutter/material.dart';
import 'package:get_together_app/features/chats_overview/presentation/widgets/message_bubble_left.dart';
import 'package:get_together_app/features/chats_overview/presentation/widgets/message_bubble_right.dart';

enum Sender { currentUser, other }

class Messagess extends StatelessWidget {
  const Messagess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        Sender messageSender = Sender.currentUser;
        if (index % 2 == 0) messageSender = Sender.other;
        if (messageSender == Sender.currentUser) return MessageBubbleRight();
        return MessageBubbleLeft();
      },
    );
  }
}
