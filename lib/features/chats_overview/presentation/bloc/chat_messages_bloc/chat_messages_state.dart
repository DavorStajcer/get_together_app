part of 'chat_messages_bloc.dart';

abstract class ChatMessagesState extends Equatable {
  const ChatMessagesState();

  @override
  List<Object> get props => [];
}

class ChatMessagesLoading extends ChatMessagesState {}

class ChatMessagesFailure extends ChatMessagesState {
  final String message;
  ChatMessagesFailure(this.message);

  @override
  List<Object> get props => [message];
}

class ChatMessagesNetworkFailure extends ChatMessagesFailure {
  ChatMessagesNetworkFailure(String message) : super(message);
}

class ChatMessagesServerFailure extends ChatMessagesFailure {
  ChatMessagesServerFailure(String message) : super(message);
}

class ChatMessagesLoaded extends ChatMessagesState {
  final List<Widget> messageWidgets;

  ChatMessagesLoaded(List<Message> messages)
      : messageWidgets = _getMessagesToWidgets(messages);

  @override
  List<Object> get props => [messageWidgets];
}

List<Widget> _getMessagesToWidgets(List<Message> messages) {
  final List<Widget> widgets = [];
  int? lastDay;
  int? lastMonth;
  int? lastYear;
  messages.forEach((message) {
    final messageDate = message.date;
    if (messageDate.day != lastDay ||
        messageDate.month != lastMonth ||
        messageDate.year != lastYear) {
      lastDay = messageDate.day;
      lastMonth = messageDate.month;
      lastYear = messageDate.year;
      widgets.add(Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(
            DateFormater().getDotFormat(messageDate),
          )));
    }
    message.sender == Sender.currentUser
        ? widgets.add(MessageBubbleRight(message))
        : widgets.add(MessageBubbleLeft(message));
  });
  return widgets;
}
