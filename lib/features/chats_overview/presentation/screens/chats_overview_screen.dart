import 'package:flutter/material.dart';
import 'package:get_together_app/features/chats_overview/presentation/widgets/chat_list_item.dart';

class ChatsOverviewScreen extends StatelessWidget {
  const ChatsOverviewScreen({Key? key}) : super(key: key);

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
                return ChatListItem();
              },
            ),
          ),
        ],
      ),
    );
  }
}
