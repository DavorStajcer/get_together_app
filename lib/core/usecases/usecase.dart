import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:get_together_app/features/chats_overview/data/models/message_model.dart';
import '../error/failure.dart';

abstract class Usecase<T, P> {
  Future<Either<Failure, T>> call(P param);
}

class NoParameters extends Equatable {
  @override
  List<Object> get props => [];
}

class SendMessagePrameters extends Equatable {
  final String eventId;
  final String message;
  SendMessagePrameters({
    required this.eventId,
    required this.message,
  });

  @override
  List<Object?> get props => [
        eventId,
        message,
      ];
}
