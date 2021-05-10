import 'package:flutter/material.dart';
import 'package:get_together_app/features/chats_overview/presentation/widgets/name_and_message.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 25),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("https://i.imgur.com/BoN9kdC.png"),
                ),
                color: Colors.grey,
                border: Border.all(
                    width: 0.2, color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          Flexible(
            flex: 4,
            child: NameAndMessage(),
          ),
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                "13s",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
