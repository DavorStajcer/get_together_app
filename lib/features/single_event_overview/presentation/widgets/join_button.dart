import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_together_app/core/widgets/network_error.dart';
import 'package:get_together_app/core/widgets/server_error.dart';
import 'package:get_together_app/features/events_overview/domain/entities/event.dart';
import 'package:get_together_app/features/make_event/presentation/widgets/event_button.dart';
import 'package:get_together_app/features/single_event_overview/domain/entities/event_join_data.dart';
import 'package:get_together_app/features/single_event_overview/presentation/bloc/join_event_cubit/join_event_cubit.dart';

class JoinButton extends StatefulWidget {
  final Event event;
  JoinButton({Key? key, required this.event}) : super(key: key);

  @override
  _JoinButtonState createState() => _JoinButtonState();
}

class _JoinButtonState extends State<JoinButton> {
  @override
  void initState() {
    BlocProvider.of<JoinEventCubit>(context).geUserJoinedStatus(
      context,
      widget.event,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JoinEventCubit, JoinEventState>(
      builder: (context, state) {
        log("STATE -> $state");

        if (state is JoinEventLoading)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (state is JoinEventNetworkFailure)
          return NetworkErrorWidget(state.message);
        if (state is JoinEventServerFailure)
          return ServerErrorWidget(state.message);

        return EventButton(
          text: (state as JoinEventFinished).buttonData.text,
          buttonColor: state.buttonData.buttonColor,
          textColor: state.buttonData.textColor,
          navigate: () {
            if (state.buttonData is ButtonJoinedUi)
              BlocProvider.of<JoinEventCubit>(context).changeJoinedStatus(
                context,
                EventJoinData(
                    event: widget.event, eventChange: EventChange.leave),
              );
            else
              BlocProvider.of<JoinEventCubit>(context).changeJoinedStatus(
                context,
                EventJoinData(
                    event: widget.event, eventChange: EventChange.join),
              );
          },
        );
      },
    );
  }
}
