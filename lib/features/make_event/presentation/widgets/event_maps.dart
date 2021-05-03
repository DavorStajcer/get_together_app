import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_together_app/features/make_event/presentation/blocs/maps_location_cubit/maps_location_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventMaps extends StatefulWidget {
  EventMaps({Key? key}) : super(key: key);

  @override
  _EventMapsState createState() => _EventMapsState();
}

class _EventMapsState extends State<EventMaps> {
  late GoogleMapController _controller;
  late Marker marker;
  late Circle eventCircle;
  late LatLng _eventLocation;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    //  _controller.animateCamera(CameraUpdate.zoomTo(5));
  }

  @override
  void initState() {
    super.initState();
    log("INIT STATEEEEEE");
    BlocProvider.of<MapsLocationCubit>(context).requestLocation();
  }

  void _setEventMarker() {
    marker = Marker(
      markerId: MarkerId(DateTime.now().toString()),
      position: _eventLocation,
      draggable: true,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      onDragEnd: (latLng) async {
        await _controller.moveCamera(CameraUpdate.newLatLng(latLng));
        marker = marker.copyWith(positionParam: latLng);
        _eventLocation = latLng;
        _controller.moveCamera(CameraUpdate.newLatLng(_eventLocation));
        /*       setState(() {
          
         
        }); */
      },
    );
  }

  void _setEventCircle() {
    eventCircle = Circle(
      circleId: CircleId(DateTime.now().toString()),
      radius: 5000,
      center: _eventLocation,
      consumeTapEvents: false,
      strokeColor: Color.fromRGBO(97, 136, 255, 1),
      visible: true,
      zIndex: 1,
      strokeWidth: 1,
      fillColor: Color.fromRGBO(97, 136, 255, 0.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapsLocationCubit, MapsLocationState>(
      builder: (context, state) {
        if (state is MapsLocationInitial)
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
            (state as MapsLocationSuccess).currentPosition;
        _eventLocation =
            LatLng(currentLocation.latitude, currentLocation.longitude);

        _setEventCircle();
        _setEventMarker();

        return GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _eventLocation,
            zoom: 12,
          ),
          myLocationEnabled: true,
          markers: {marker},
          circles: {eventCircle},
        );
      },
    );
  }
}
