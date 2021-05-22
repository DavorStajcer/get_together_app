import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class ChatSnippet extends Equatable {
  final String eventId;
  final String eventName;
  final String adminImageUrl;
  @protected
  final DateTime? lastMessageDate;
  final String? lastMessageSnippet;
  String get sentBeforeString {
    if (lastMessageDate == null) {
      return ".s";
    }
    final secondsFormLastMessage =
        DateTime.now().difference(lastMessageDate!).inSeconds;
    double fakeMinutes = secondsFormLastMessage / 60;
    final hours = fakeMinutes / 60;
    final minutes = fakeMinutes % 60;
    final seconds = secondsFormLastMessage % 60;

    return hours != 0
        ? "${hours.toStringAsFixed(0)}h ${minutes.toStringAsFixed(0)}m ${seconds}s"
        : minutes != 0
            ? "${minutes}m ${seconds}s"
            : "${seconds}s";
  }

  ChatSnippet({
    required this.eventId,
    required this.eventName,
    required this.adminImageUrl,
    required DateTime? lastMessageDate,
    required this.lastMessageSnippet,
  }) : lastMessageDate = lastMessageDate;

  @override
  List<Object?> get props => [
        eventId,
        eventName,
        adminImageUrl,
        lastMessageDate,
        lastMessageSnippet,
      ];
}
