import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_together_app/core/error/failure.dart';
import 'package:get_together_app/core/error/success.dart';
import 'package:get_together_app/core/network.dart/network_info.dart';
import 'package:get_together_app/features/chats_overview/data/models/message_model.dart';
import 'package:get_together_app/features/chats_overview/domain/enitites/message.dart';
import 'package:get_together_app/features/chats_overview/domain/repositories/event_messages_repository.dart';
import 'package:get_together_app/features/chats_overview/presentation/widgets/chat_messages.dart';

class EventMessageRepositoryImpl extends EventMessagesRepository {
  FirebaseAuth firebaseAuth;
  FirebaseFirestore firebaseFirestore;
  NetworkInfo networkInfo;
  late StreamController<Either<Failure, List<Message>>>
      _messageStreamController;
  int _lastPageNum = 0;
  StreamSubscription<QuerySnapshot>? _currentMessageSubscription;
  StreamSubscription<DocumentSnapshot>? _currentSnippetSubscription;

  EventMessageRepositoryImpl({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firebaseFirestore,
    required this.networkInfo,
    // required this.locationService,
  })   : firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<DocumentSnapshot> listenToMessageSnippetChanges(
    String eventId,
  ) {
    return firebaseFirestore.collection("chats").doc(eventId).snapshots();
  }

  @override
  Stream<Either<Failure, List<Message>>> listenToChatMessages(String eventId) {
    _messageStreamController = StreamController();
    _currentSnippetSubscription = firebaseFirestore
        .collection("chats")
        .doc(eventId)
        .snapshots()
        .listen((chatSnippet) {
      final data = chatSnippet.data();
      if (data != null) {
        if (_lastPageNum != data["lastPageNum"]) {
          _lastPageNum = data["lastPageNum"];
          _listenToPage(eventId);
        }
      }
    }, onError: (error) {
      return Left(NetworkFailure());
    });
    return _messageStreamController.stream;
  }

  void _listenToPage(String eventId) {
    if (_currentMessageSubscription != null)
      _currentMessageSubscription!.cancel();
    _currentMessageSubscription = firebaseFirestore
        .collection("chats")
        .doc(eventId)
        .collection("messages")
        .doc("page$_lastPageNum")
        .collection("page_messages")
        .orderBy("timestamp")
        .snapshots()
        .listen((pageMessages) {
      final messages = pageMessages.docs.map((doc) {
        final currentUserUid = firebaseAuth.currentUser!.uid;
        final senderId = doc.data()["senderId"];
        Sender messageSender = Sender.other;
        if (currentUserUid == senderId) messageSender = Sender.currentUser;
        return MessageModel.fromJsonMap(messageSender, doc.data());
      }).toList();
      _messageStreamController.sink.add(Right(messages));
    },
            onError: (error) =>
                _messageStreamController.sink.add(Left(ServerFailure())));
  }

  Future<void> stopListeningToChatMessages() async {
    _lastPageNum = 0;
    await _messageStreamController.sink.close();
    if (_currentMessageSubscription != null)
      await _currentMessageSubscription!.cancel();
    if (_currentSnippetSubscription != null)
      await _currentSnippetSubscription!.cancel();
  }

  @override
  Future<Either<Failure, Success>> addMessage(
      String eventId, String message) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected == false) return Left(NetworkFailure());
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) return Left(ServerFailure());
    final String currentUid = currentUser.uid;
    try {
      final eventSnippetSnapshot =
          await firebaseFirestore.collection("chats").doc(eventId).get();
      if (!eventSnippetSnapshot.exists) return Left(ServerFailure());
      final snippetData = eventSnippetSnapshot.data();
      if (snippetData == null) return Left(ServerFailure());
      final int lastPageNum = snippetData["lastPageNum"];

      final userSnapashot =
          await firebaseFirestore.collection("users").doc(currentUid).get();
      final userData = userSnapashot.data();
      if (userData == null) return Left(ServerFailure());
      final String userImageUrl = userData["imageUrl"];
      final String username = userData["username"];
      await firebaseFirestore
          .collection("chats")
          .doc(eventId)
          .collection("messages")
          .doc("page$lastPageNum")
          .collection("page_messages")
          .add({
        "senderId": currentUid,
        "username": username,
        "userImageUrl": userImageUrl,
        "content": message,
        "timestamp": FieldValue.serverTimestamp(),
      });
      return Right(Success());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
