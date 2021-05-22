import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_together_app/core/widgets/network_error.dart';
import 'package:get_together_app/features/events_overview/domain/entities/event.dart';
import 'package:get_together_app/features/events_overview/presentation/bloc/event_pick_cubit/event_pick_cubit_cubit.dart';
import 'package:get_together_app/features/events_overview/presentation/bloc/load_events_bloc/events_overview_bloc.dart';
import 'package:get_together_app/features/make_event/presentation/blocs/maps_location_cubit/maps_location_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsView extends StatefulWidget {
  MapsView({Key? key}) : super(key: key);

  @override
  _MapsViewState createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  late GoogleMapController _controller;
  late LatLng _userLocation;
  final Set<Marker> _markers = {};
  late Circle eventCircle;

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MapsLocationCubit>(context).requestLocation();
  }

  void _setEventMarkers(List<Event> events) {
    events.forEach((event) {
      _markers.add(
        Marker(
          markerId: MarkerId(DateTime.now().toString()),
          position: event.location,
          draggable: false,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        ),
      );
    });
  }

/*   void _setEventCircle() {
    eventCircle = Circle(
      circleId: CircleId(DateTime.now().toString()),
      radius: 5000,
      center: _userLocation,
      consumeTapEvents: false,
      strokeColor: Color.fromRGBO(97, 136, 255, 1),
      visible: true,
      zIndex: 1,
      strokeWidth: 1,
      fillColor: Color.fromRGBO(97, 136, 255, 0.2),
    );
  } */

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapsLocationCubit, MapsLocationState>(
      builder: (context, state) {
        if (state is MapsLocationNotLoaded)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (state is MapsLocationFailure)
          return Center(
            child: Text(
              state.errorMessage,
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 18),
            ),
          );
        final Position currentLocation =
            (state as MapsLocationLoaded).currentPosition;
        _userLocation =
            LatLng(currentLocation.latitude, currentLocation.longitude);

        return BlocBuilder<EventsOverviewBloc, EventsOverviewState>(
          builder: (context, state) {
            if (state is EventsOverviewNetworkFailure)
              return NetworkErrorWidget(state.message);
            if (state is EventsOverviewServerFailure)
              return NetworkErrorWidget(state.message);
            if (state is EventsOverviewLoading)
              return Center(
                child: CircularProgressIndicator(),
              );
            _setEventMarkers((state as EventsOverviewLoaded).events);
            return BlocListener<EventPickCubit, PickedEventState>(
              listener: (context, state) {
                _controller
                    .animateCamera(CameraUpdate.newLatLng(state.location!));
              },
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _userLocation,
                  zoom: 12,
                ),
                myLocationEnabled: true,
                markers: _markers,
              ),
            );
          },
        );
      },
    );
  }
}
