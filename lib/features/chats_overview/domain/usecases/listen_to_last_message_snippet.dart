import 'package:dartz/dartz.dart';
import 'package:get_together_app/core/error/failure.dart';
import 'package:get_together_app/features/chats_overview/data/models/chat_snippet_model.dart';
import 'package:get_together_app/features/chats_overview/domain/repositories/event_messages_repository.dart';
import 'package:get_together_app/features/chats_overview/presentation/bloc/message_snippet_bloc/chat_snippet_bloc.dart';

class ListenToLastMessageSnippet {
  EventMessagesRepository eventMessagesRepository;

  ListenToLastMessageSnippet(this.eventMessagesRepository);

  void call(ChatSnippetBloc bloc, String eventId) {
    eventMessagesRepository.listenToMessageSnippetChanges(eventId).listen(
        (docSnapshot) {
      final docData = docSnapshot.data();

      if (docData != null)
        bloc.add(
          ChatSnippetChnaged(
            Right(
              ChatSnippetModel.fromJsonMap(eventId, docData),
            ),
          ),
        );
    }, onError: (error) {
      bloc.add(
        ChatSnippetChnaged(
          Left(
            NetworkFailure(),
          ),
        ),
      );
    });
  }
}
