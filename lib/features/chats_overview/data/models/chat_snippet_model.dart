import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_together_app/features/chats_overview/domain/enitites/chat_snippet.dart';

class ChatSnippetModel extends ChatSnippet {
  ChatSnippetModel({
    required String eventId,
    required String eventName,
    required String adminImageUrl,
    @protected required DateTime? lastMessageDate,
    required final String? lastMessageSnippet,
  }) : super(
            eventId: eventId,
            eventName: eventName,
            adminImageUrl: adminImageUrl,
            lastMessageDate: lastMessageDate,
            lastMessageSnippet: lastMessageSnippet);

  factory ChatSnippetModel.fromJsonMap(
          String eventId, Map<String, dynamic> json) =>
      ChatSnippetModel(
        eventId: eventId,
        eventName: json["eventName"],
        adminImageUrl: json["adminImageUrl"],
        lastMessageDate: json["lastMessageDate"] != null
            ? (json["lastMessageDate"] as Timestamp).toDate()
            : null,
        lastMessageSnippet: json["lastMessageSnippet"],
      );

  Map<String, dynamic> toJsonMap() => {
        "eventName": this.eventName,
        "adminImageUrl": this.adminImageUrl,
        "lastMessageDate": lastMessageDate,
        "lastMessageSnippet": this.lastMessageSnippet,
      };
}
