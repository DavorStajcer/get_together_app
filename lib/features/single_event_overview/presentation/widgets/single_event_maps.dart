import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SingleEventMaps extends StatelessWidget {
  const SingleEventMaps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _eventLocation = LatLng(-34.397, 150.644);
    final _initalCameraPosition = CameraPosition(
      target: _eventLocation,
      zoom: 13,
    );

    final _eventMarker = Marker(
      markerId: MarkerId(DateTime.now().toString()),
      position: _eventLocation,
      draggable: false,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    );

    return GoogleMap(
      initialCameraPosition: _initalCameraPosition,
      markers: {
        _eventMarker,
      },
    );
  }
}
