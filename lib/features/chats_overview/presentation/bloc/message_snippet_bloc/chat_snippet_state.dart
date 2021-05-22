part of 'chat_snippet_bloc.dart';

abstract class ChatSnippetState extends Equatable {
  const ChatSnippetState();

  @override
  List<Object> get props => [];
}

class ChatSnippetLoading extends ChatSnippetState {}

class ChatSnippetFailure extends ChatSnippetState {
  final String message;
  ChatSnippetFailure(this.message);

  @override
  List<Object> get props => [message];
}

class ChatSnippetNetworkFailure extends ChatSnippetFailure {
  ChatSnippetNetworkFailure(String message) : super(message);
}

class ChatSnippetServerFailure extends ChatSnippetFailure {
  ChatSnippetServerFailure(String message) : super(message);
}

class ChatSnippetLoaded extends ChatSnippetState {
  final ChatSnippet chatSnippet;
  ChatSnippetLoaded(this.chatSnippet);

  @override
  List<Object> get props => [chatSnippet];
}
