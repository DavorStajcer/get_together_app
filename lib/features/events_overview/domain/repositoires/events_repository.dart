import 'package:dartz/dartz.dart';
import 'package:get_together_app/core/error/failure.dart';
import 'package:get_together_app/core/error/success.dart';
import 'package:get_together_app/features/events_overview/data/models/event_model.dart';
import 'package:get_together_app/features/events_overview/domain/entities/event.dart';
import 'package:get_together_app/features/make_event/domain/entities/create_event_data.dart';

abstract class EventsRepository {
  Future<Either<Failure, Event>> getEvent(String eventId);
  Future<Either<Failure, List<Event>>> getAllEvents();
  Future<Either<Failure, Success>> createEvent(CreateEventData event);
}
