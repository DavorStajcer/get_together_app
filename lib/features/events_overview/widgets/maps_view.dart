import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_together_app/features/make_event/presentation/blocs/maps_location_cubit/maps_location_cubit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

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

  void _setEventMarker(LatLng location) {
    _markers.add(Marker(
      markerId: MarkerId(DateTime.now().toString()),
      position: location,
      draggable: false,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    ));
  }

  void _setEventCircle() {
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
        _userLocation =
            LatLng(currentLocation.latitude, currentLocation.longitude);

        _setEventCircle();
        _setEventMarker(_userLocation);

        return GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _userLocation,
            zoom: 12,
          ),
          myLocationEnabled: true,
          markers: _markers,
          circles: {eventCircle},
        );
      },
    );
  }
}
