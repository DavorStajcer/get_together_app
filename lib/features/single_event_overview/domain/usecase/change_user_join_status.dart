import 'package:get_together_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:get_together_app/core/error/success.dart';
import 'package:get_together_app/core/usecases/usecase.dart';
import 'package:get_together_app/features/single_event_overview/domain/entities/event_join_data.dart';
import 'package:get_together_app/features/single_event_overview/domain/repositoires/user_events_repository.dart';

class ChangeUserJoinStatus extends Usecase<Success, EventJoinData> {
  final UserEventsRepository userEventsRepository;
  ChangeUserJoinStatus({required this.userEventsRepository});

  @override
  Future<Either<Failure, Success>> call(EventJoinData eventJoinData) async {
    return await userEventsRepository.changeUserJoinStatus(eventJoinData);
  }
}
