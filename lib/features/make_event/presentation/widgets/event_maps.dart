import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_together_app/features/make_event/presentation/blocs/event_cubit/event_cubit.dart';
import 'package:get_together_app/features/make_event/presentation/blocs/event_cubit/event_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventMaps extends StatefulWidget {
  const EventMaps({Key? key}) : super(key: key);

  @override
  _EventMapsState createState() => _EventMapsState();
}

class _EventMapsState extends State<EventMaps> {
  GoogleMapController? _controller;

  Marker _generateEventMarker(LatLng eventLocation, EventCubit eventCubit) =>
      Marker(
        markerId: MarkerId(DateTime.now().toString()),
        position: eventLocation,
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        onDragEnd: (newLocation) => _onMarkerDragEnd(newLocation, eventCubit),
      );

  void _onMarkerDragEnd(LatLng newLocation, EventCubit eventCubit) {
    _generateEventMarker(newLocation, eventCubit);
    eventCubit.evenLocationChanged(newLocation);
  }

  Circle _generateEventCircle(LatLng eventLocation) => Circle(
        circleId: CircleId(DateTime.now().toString()),
        radius: 5000,
        center: eventLocation,
        consumeTapEvents: false,
        strokeColor: Color.fromRGBO(97, 136, 255, 1),
        visible: true,
        zIndex: 1,
        strokeWidth: 1,
        fillColor: Color.fromRGBO(97, 136, 255, 0.2),
      );

  void _onMapsCreated(GoogleMapController controller) {
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventCubit, EventState>(
      builder: (context, state) {
        log("MAPS : STATE -> $state");
        if (state is EventStateUnfinished) {
          log("EVENT TYPE ->${state.createEventData.type}");
        }
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

        final _eventLocation =
            (state as EventStateUnfinished).createEventData.location;
        final cricle = _generateEventCircle(_eventLocation);
        final marker = _generateEventMarker(
            _eventLocation, BlocProvider.of<EventCubit>(context));
        log("MAPS : LOCATION -> $_eventLocation");
        if (_controller != null) {
          _controller!.animateCamera(CameraUpdate.newLatLng(_eventLocation));
        }
        return GoogleMap(
          onMapCreated: _onMapsCreated,
          initialCameraPosition: CameraPosition(
            target: _eventLocation,
            zoom: 12,
          ),
          myLocationEnabled: true,
          markers: {marker},
          circles: {cricle},
        );
      },
    );
  }
}
