import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_together_app/core/widgets/network_error.dart';
import 'package:get_together_app/core/widgets/server_error.dart';
import 'package:get_together_app/features/chats_overview/presentation/bloc/chat_messages_bloc/chat_messages_bloc.dart';
import 'package:get_together_app/features/chats_overview/presentation/widgets/message_bubble_left.dart';
import 'package:get_together_app/features/chats_overview/presentation/widgets/message_bubble_right.dart';

enum Sender { currentUser, other }

class ChatMessages extends StatefulWidget {
  final String eventId;
  const ChatMessages(this.eventId, {Key? key}) : super(key: key);

  @override
  _ChatMessagesState createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  late ChatMessagesBloc chatMessagesBloc;

  @override
  void initState() {
    chatMessagesBloc = BlocProvider.of<ChatMessagesBloc>(context)
      ..add(ChatMessagesScreenInitialized(widget.eventId));
    super.initState();
  }

  @override
  void dispose() {
    log("DISPOSING STATE");
    chatMessagesBloc.add(ChatMessagesLeavignScreen());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatMessagesBloc, ChatMessagesState>(
      builder: (context, state) {
        if (state is ChatMessagesNetworkFailure)
          return NetworkErrorWidget(state.message);
        if (state is ChatMessagesServerFailure)
          return ServerErrorWidget(state.message);
        if (state is ChatMessagesLoading)
          return Center(
            child: CircularProgressIndicator(),
          );
        if ((state as ChatMessagesLoaded).messageWidgets.length == 0)
          return Center(
            child: Text("No messages yet"),
          );
        return ListView.builder(
          shrinkWrap: true,
          itemCount: (state as ChatMessagesLoaded).messageWidgets.length,
          itemBuilder: (context, index) => state.messageWidgets[index],
        );
      },
    );
  }
}
