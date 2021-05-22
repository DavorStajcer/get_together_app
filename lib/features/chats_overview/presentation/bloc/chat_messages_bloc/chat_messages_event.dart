part of 'chat_messages_bloc.dart';

abstract class ChatMessagesEvent extends Equatable {
  const ChatMessagesEvent();

  @override
  List<Object> get props => [];
}

class ChatMessagesScreenInitialized extends ChatMessagesEvent {
  final String eventId;
  ChatMessagesScreenInitialized(this.eventId);
}

class ChatMessagesLeavignScreen extends ChatMessagesEvent {}

class ChatMessagesChanged extends ChatMessagesEvent {
  final Either<Failure, List<Message>> response;
  ChatMessagesChanged(this.response);

  @override
  List<Object> get props => [response];
}
