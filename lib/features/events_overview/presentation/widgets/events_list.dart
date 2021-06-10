import 'dart:developer';

import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_together_app/core/widgets/event_card/event_card.dart';
import 'package:get_together_app/core/widgets/network_error.dart';
import 'package:get_together_app/core/widgets/server_error.dart';
import 'package:get_together_app/features/events_overview/domain/entities/event.dart';
import 'package:get_together_app/features/events_overview/presentation/bloc/event_pick_cubit/event_pick_cubit_cubit.dart';

import 'package:get_together_app/features/events_overview/presentation/bloc/load_events_bloc/events_overview_bloc.dart';
import 'package:get_together_app/features/events_overview/presentation/widgets/no_city_events.dart';

class EventsList extends StatelessWidget {
  const EventsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EventsOverviewBloc>(context).add(EventsScreenInitialized());
    return BlocBuilder<EventsOverviewBloc, EventsOverviewState>(
      builder: (context, state) {
        log("state -> $state");
        if (state is EventsOverviewLoading)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (state is EventsOverviewNetworkFailure)
          return NetworkErrorWidget(
            state.message,
            onReload: () {},
          );
        if (state is EventsOverviewServerFailure)
          return ServerErrorWidget(
            state.message,
            onReload: () {},
          );
        return (state as EventsOverviewLoaded).events.length == 0
            ? NoCityEvents()
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.events.length,
                itemBuilder: (context, index) {
                  return BlocBuilder<EventPickCubit, PickedEventState>(
                    builder: (context, pickedState) {
                      final Event event = state.events[index];
                      return EventCard(
                        event: event,
                        color: event.eventId == pickedState.pickedEventId
                            ? Color.fromRGBO(255, 203, 181, 1)
                            : Colors.white,
                        elevation:
                            event.eventId == pickedState.pickedEventId ? 4 : 1,
                      );
                    },
                  );
                },
              );
      },
    );
  }
}
