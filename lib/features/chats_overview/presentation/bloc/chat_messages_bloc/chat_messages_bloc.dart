import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_together_app/core/error/failure.dart';
import 'package:get_together_app/core/util/date_formater.dart';
import 'package:get_together_app/features/chats_overview/domain/enitites/message.dart';
import 'package:get_together_app/features/chats_overview/domain/usecases/listen_to_messages.dart';
import 'package:get_together_app/features/chats_overview/presentation/widgets/chat_messages.dart';
import 'package:get_together_app/features/chats_overview/presentation/widgets/message_bubble_left.dart';
import 'package:get_together_app/features/chats_overview/presentation/widgets/message_bubble_right.dart';

part 'chat_messages_event.dart';
part 'chat_messages_state.dart';

class ChatMessagesBloc extends Bloc<ChatMessagesEvent, ChatMessagesState> {
  final ListenToMessages listenToMessages;
  ChatMessagesBloc(
    this.listenToMessages,
  ) : super(ChatMessagesLoading());

  @override
  Stream<ChatMessagesState> mapEventToState(
    ChatMessagesEvent event,
  ) async* {
    if (event is ChatMessagesScreenInitialized)
      listenToMessages(this, event.eventId);
    else if (event is ChatMessagesLeavignScreen)
      await listenToMessages.stop();
    else {
      final response = (event as ChatMessagesChanged).response;
      yield response.fold((failure) {
        if (failure is NetworkFailure)
          return ChatMessagesNetworkFailure(failure.message);
        else
          return ChatMessagesServerFailure(failure.message);
      }, (messages) => ChatMessagesLoaded(messages));
    }
  }
}
