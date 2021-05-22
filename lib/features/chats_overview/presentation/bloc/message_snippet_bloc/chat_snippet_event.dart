part of 'chat_snippet_bloc.dart';

abstract class ChatSnippetEvent extends Equatable {
  const ChatSnippetEvent();

  @override
  List<Object?> get props => [];
}

class ChatsScreenInitialized extends ChatSnippetEvent {
  final String eventId;
  ChatsScreenInitialized(this.eventId);
}

class ChatSnippetChnaged extends ChatSnippetEvent {
  final Either<Failure, ChatSnippet> chatSnippet;
  ChatSnippetChnaged(this.chatSnippet);

  @override
  List<Object?> get props => [chatSnippet];
}
