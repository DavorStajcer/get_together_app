import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:get_together_app/core/error/failure.dart';
import 'package:get_together_app/features/chats_overview/domain/enitites/chat_snippet.dart';
import 'package:get_together_app/features/chats_overview/domain/usecases/listen_to_last_message_snippet.dart';

part 'chat_snippet_event.dart';
part 'chat_snippet_state.dart';

class ChatSnippetBloc extends Bloc<ChatSnippetEvent, ChatSnippetState> {
  ListenToLastMessageSnippet listenToLastMessageSnippet;
  ChatSnippetBloc({
    required this.listenToLastMessageSnippet,
  }) : super(ChatSnippetLoading());

  @override
  Stream<ChatSnippetState> mapEventToState(
    ChatSnippetEvent event,
  ) async* {
    if (event is ChatsScreenInitialized)
      listenToLastMessageSnippet.call(this, event.eventId);
    else
      yield (event as ChatSnippetChnaged).chatSnippet.fold(
        (failure) {
          if (failure is ServerFailure)
            return ChatSnippetServerFailure(failure.message);
          else
            return ChatSnippetNetworkFailure(failure.message);
        },
        (chatSnippet) => ChatSnippetLoaded(chatSnippet),
      );
  }
}
