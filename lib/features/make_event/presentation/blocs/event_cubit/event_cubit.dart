import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:get_together_app/core/error/failure.dart';
import 'package:get_together_app/core/util/date_formater.dart';
import 'package:get_together_app/features/make_event/domain/entities/create_event_data.dart';
import 'package:get_together_app/features/make_event/domain/usecases/create_event.dart';
import 'package:get_together_app/features/make_event/presentation/blocs/event_card_order_cubit/event_card_order_cubit.dart';
import 'package:get_together_app/features/make_event/presentation/blocs/event_cubit/event_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const String stateErrorMessage =
    "We experienced a bug in the application, please try again.";

class EventCubit extends Cubit<EventState> {
  final CreateEvent _createEvent;
  final DateFormater dateFormater = DateFormater();
  EventCubit(this._createEvent, {DateFormater? dateFormater})
      : super(EventStateUnfinished());

  void eventTypeChanged(EventType newType) {
    final CreateEventData newData =
        (state as EventStateUnfinished).createEventData.copyWith(type: newType);
    _emitNewSate(newData);
  }

  void evenLocationChanged(LatLng newlocation) {
    final CreateEventData newData = (state as EventStateUnfinished)
        .createEventData
        .copyWith(location: newlocation);
    _emitNewSate(newData);
  }

  void eventDescriptionChanged(String newDescription) {
    final CreateEventData newData = (state as EventStateUnfinished)
        .createEventData
        .copyWith(description: newDescription);
    _emitNewSate(newData);
  }

  void eventDateChanged(DateTime newDate) {
    final CreateEventData newData = (state as EventStateUnfinished)
        .createEventData
        .copyWith(dateString: dateFormater.getDotFormat(newDate));
    _emitNewSate(newData);
  }

  void eventTimeChanged(String newTime) {
    final CreateEventData newData = (state as EventStateUnfinished)
        .createEventData
        .copyWith(timeString: newTime);
    _emitNewSate(newData);
  }

  void createEvent() async {
    print("CREATING EVENT .. current state -> $state");
    if (!(state is EventStateFinished))
      emit(EventStateServerFailure(stateErrorMessage));
    else {
      final CreateEventData createEventData =
          (state as EventStateFinished).createEventData;
      emit(EventStateLoading());
      final response = await _createEvent(createEventData);
      final eventToEmit = response.fold((failure) {
        if (failure is NetworkFailure)
          return EventStateNetworkFailure(failure.message);
        else
          return EventStateServerFailure(failure.message);
      }, (success) => EventStateCreated());
      emit(eventToEmit);
    }
  }

  void _emitNewSate(CreateEventData newData) {
    log("CUBIT NEW DATA -> $newData");
    if (_areAllFieldsValid(newData))
      emit(EventStateFinished(newData));
    else
      emit(EventStateUnfinished(createEventData: newData));
  }

  bool _areAllFieldsValid(CreateEventData createEventData) {
    if (createEventData.dateString == null ||
        createEventData.timeString == null) return false;
    return createEventData.dateString!.isNotEmpty &&
        createEventData.timeString!.isNotEmpty &&
        createEventData.description.isNotEmpty;
  }
}
