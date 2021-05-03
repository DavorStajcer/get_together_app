part of 'maps_location_cubit.dart';

abstract class MapsLocationState extends Equatable {
  const MapsLocationState();

  @override
  List<Object> get props => [];
}

class MapsLocationInitial extends MapsLocationState {}

class MapsLocationSuccess extends MapsLocationState {
  final Position currentPosition;
  MapsLocationSuccess({required this.currentPosition});
}

class MapsLocationFailure extends MapsLocationState {
  final String errorMessage;
  MapsLocationFailure({required this.errorMessage});
}
