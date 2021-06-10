import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_together_app/core/widgets/network_error.dart';
import 'package:get_together_app/core/widgets/server_error.dart';
import 'package:get_together_app/features/chats_overview/presentation/bloc/message_snippet_bloc/chat_snippet_bloc.dart';
import 'package:get_together_app/features/chats_overview/presentation/screens/chat_screen.dart';
import 'package:get_together_app/features/chats_overview/presentation/widgets/name_and_message.dart';

class ChatSnippet extends StatelessWidget {
  final String eventId;
  const ChatSnippet(this.eventId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ChatSnippetBloc>(context)
        .add(ChatsScreenInitialized(eventId));
    return BlocBuilder<ChatSnippetBloc, ChatSnippetState>(
      builder: (context, state) {
        if (state is ChatSnippetLoading)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (state is ChatSnippetNetworkFailure)
          return NetworkErrorWidget(
            state.message,
            onReload: () {},
          );
        if (state is ChatSnippetServerFailure)
          return ServerErrorWidget(
            state.message,
            onReload: () {},
          );

        return GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
            ChatScreen.route,
            arguments: ((state as ChatSnippetLoaded).chatSnippet),
          ),
          child: Container(
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
                        image: NetworkImage((state as ChatSnippetLoaded)
                            .chatSnippet
                            .adminImageUrl),
                      ),
                      color: Colors.grey,
                      border: Border.all(
                          width: 0.2, color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: NameAndMessage(
                    name: state.chatSnippet.eventName,
                    messageSnippet: state.chatSnippet.lastMessageSnippet ?? "-",
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        state.chatSnippet.sentBeforeString,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
