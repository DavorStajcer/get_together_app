import 'package:equatable/equatable.dart';
import 'package:get_together_app/features/chats_overview/presentation/widgets/chat_messages.dart';

class Message extends Equatable {
  //final String userId;
  final String username;
  final String userImageUrl;
  final String content;
  //final Timestamp timestamp;
  final Sender sender;
  final DateTime? date;

  Message({
    // required this.userId,
    required this.username,
    required this.userImageUrl,
    required this.content,
    required this.date,
    required this.sender,
  });

  @override
  List<Object?> get props => [
        username,
        userImageUrl,
        content,
        sender,
        date,
      ];
}
