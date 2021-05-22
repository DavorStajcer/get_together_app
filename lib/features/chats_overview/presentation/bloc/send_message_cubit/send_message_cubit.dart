import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_together_app/core/usecases/usecase.dart';
import 'package:get_together_app/features/chats_overview/domain/usecases/send_message.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  final SendMessage sendMessage;
  SendMessageCubit(this.sendMessage) : super(SendMessageNormal());

  void sendNewMessage(String eventId, String message) async {
    if (state is SendMessageFailure) emit(SendMessageNormal());
    final response = await sendMessage(
        SendMessagePrameters(eventId: eventId, message: message));
    response.fold(
        (failure) => emit(
              SendMessageFailure(failure.message),
            ),
        (success) => null);
  }
}
