import 'package:equatable/equatable.dart';
import 'package:get_together_app/features/make_event/domain/entities/create_event_data.dart';
import 'package:get_together_app/features/make_event/presentation/blocs/event_card_order_cubit/event_card_order_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class EventState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EventStateLoading extends EventState {}

abstract class EventStateFailure extends EventState {
  final String message;
  EventStateFailure(this.message);
}

class EventStateNetworkFailure extends EventStateFailure {
  EventStateNetworkFailure(String message) : super(message);
}

class EventStateServerFailure extends EventStateFailure {
  EventStateServerFailure(String message) : super(message);
}

class EventStateCreated extends EventState {}

class EventStateUnfinished extends EventState {
  final CreateEventData createEventData;

  EventStateUnfinished({CreateEventData? createEventData})
      : createEventData = createEventData ??
            CreateEventData(
              type: EventType.games,
              location: LatLng(0, 0),
              description: "This is some event.",
              dateString: null,
              timeString: null,
            );
  @override
  List<Object?> get props => [createEventData];
}

class EventStateFinished extends EventStateUnfinished {
  EventStateFinished(CreateEventData createEventData)
      : super(createEventData: createEventData);
}
