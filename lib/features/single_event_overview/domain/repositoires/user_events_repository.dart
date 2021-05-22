import 'package:dartz/dartz.dart';
import 'package:get_together_app/core/error/failure.dart';
import 'package:get_together_app/core/error/success.dart';
import 'package:get_together_app/features/events_overview/domain/entities/event.dart';
import 'package:get_together_app/features/single_event_overview/domain/entities/event_join_data.dart';

abstract class UserEventsRepository {
  Future<Either<Failure, bool>> checkIsUserJoined(Event event);
  Future<Either<Failure, Success>> changeUserJoinStatus(
      EventJoinData eventJoinData);
  Future<Either<Failure, List<String>>> getAllUserEvents();
}
