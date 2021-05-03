import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_together_app/core/error/failure.dart';
import 'package:get_together_app/core/network.dart/network_info.dart';

abstract class LocationService {
  final NetworkInfo networkInfo;
  Future<Either<Failure, Position>> getLocation();
  LocationService({required this.networkInfo});
}

class LocationServiceImpl extends LocationService {
  LocationServiceImpl(NetworkInfo networkInfo)
      : super(networkInfo: networkInfo);

  @override
  Future<Either<Failure, Position>> getLocation() async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) return Left(NetworkFailure("Check your connection."));
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Left(LocationFailure('Location services are disabled.'));
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Left(LocationFailure('Location permissions are denied'));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Left(LocationFailure(
          'Location permissions are permanently denied, we cannot request permissions.'));
    }
    final position = await Geolocator.getCurrentPosition();
    return Right(position);
  }
}
