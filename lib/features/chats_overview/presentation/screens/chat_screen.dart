import 'package:flutter/material.dart';
import 'package:get_together_app/features/chats_overview/presentation/widgets/messages.dart';
import 'package:get_together_app/features/chats_overview/presentation/widgets/send_message.dart';

class ChatScreen extends StatelessWidget {
  static const route = "/chat_screen";
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuerData = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text("Zimica"),
    );
    return Scaffold(
      appBar: appBar,
      body: Container(
        color: Color.fromRGBO(237, 231, 246, 1),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.bottomCenter,
                child: Messagess(),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              padding: EdgeInsets.only(left: 15),
              child: SendMessage(),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
