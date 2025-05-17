part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {}

class GetUserCurrentLocation extends LocationEvent {
  @override
  List<Object?> get props => [];
}

class UpdateCurrentLocation extends LocationEvent {
  final LatLng position;

  UpdateCurrentLocation(this.position);

  @override
  List<Object?> get props => [position];
}

class OnCameraMove extends LocationEvent {
  final LatLng position;

  OnCameraMove(this.position);

  @override
  List<Object?> get props => [position];
}
