//@dart=2.6

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_together_app/core/error/failure.dart';
import 'package:get_together_app/features/make_event/presentation/blocs/maps_location_cubit/maps_location_cubit.dart';
import 'package:get_together_app/core/maps/location_service.dart';
import 'package:mockito/mockito.dart';

class LocationServiceMock extends Mock implements LocationService {}

void main() {
  LocationServiceMock locationServiceMock;
  MapsLocationCubit mapsLocationCubit;
  Position tPosition;

  setUp(() {
    locationServiceMock = LocationServiceMock();
    mapsLocationCubit = MapsLocationCubit(locationService: locationServiceMock);
    tPosition = Position(
      accuracy: 1,
      altitude: 1,
      floor: 1,
      heading: 1,
      latitude: 1,
      longitude: 1,
      speedAccuracy: 1,
      timestamp: DateTime.now(),
      speed: 1,
    );
  });

  blocTest("emit MapsLocationFailure when cant get location",
      build: () {
        when(locationServiceMock.getLocation()).thenAnswer(
            (realInvocation) async => Left(LocationFailure(
                message: "Application needs permission to acces location.")));
        return mapsLocationCubit;
      },
      act: (cubit) {
        (cubit as MapsLocationCubit).requestLocation();
      },
      expect: () => [
            MapsLocationFailure(
                errorMessage: "Application needs permission to acces location.")
          ],
      verify: (cubit) => {verify(locationServiceMock.getLocation())});

  blocTest("emit MapsLocationSuccess when position/location is got",
      build: () {
        when(locationServiceMock.getLocation()).thenAnswer(
          (realInvocation) async => Right(
            tPosition,
          ),
        );
        return mapsLocationCubit;
      },
      act: (cubit) {
        (cubit as MapsLocationCubit).requestLocation();
      },
      expect: () => [MapsLocationSuccess(currentPosition: tPosition)],
      verify: (cubit) => {verify(locationServiceMock.getLocation())});
}
