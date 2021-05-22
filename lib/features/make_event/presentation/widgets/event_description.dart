import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_together_app/features/make_event/presentation/blocs/event_cubit/event_cubit.dart';
import 'package:get_together_app/features/make_event/presentation/blocs/event_cubit/event_state.dart';

class EventDescription extends StatefulWidget {
  EventDescription({Key? key}) : super(key: key);

  @override
  _EventDescriptionState createState() => _EventDescriptionState();
}

class _EventDescriptionState extends State<EventDescription> {
  // final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(bottom: 30),
      child: BlocConsumer<EventCubit, EventState>(
        listener: (context, state) {
          print("LISTENER STATE -> $state");
        },
        listenWhen: (previousState, currentState) =>
            currentState is EventStateFinished,
        builder: (context, state) {
          log("STATE IS -> $state ");
          if (state is EventStateNetworkFailure)
            return Center(
              child: Text(state.message),
            );
          if (state is EventStateServerFailure)
            return Center(
              child: Text(state.message),
            );
          if (state is EventStateLoading || state is EventStateCreated)
            return Center(
              child: CircularProgressIndicator(),
            );

          return TextFormField(
            initialValue:
                (state as EventStateUnfinished).createEventData.description,
            decoration: new InputDecoration(
              border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(15.0),
                  ),
                  borderSide: BorderSide.none),
              filled: true,
              hintStyle: new TextStyle(color: Color.fromRGBO(255, 175, 150, 1)),
              hintText: "Type event description...",
              fillColor: Colors.white,
            ),
            maxLines: 15,
            onChanged: (value) => BlocProvider.of<EventCubit>(context)
                .eventDescriptionChanged(value),
          );
        },
      ),
    );
  }
}
