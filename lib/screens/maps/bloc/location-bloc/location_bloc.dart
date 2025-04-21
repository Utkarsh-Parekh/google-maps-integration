import 'dart:async';
import 'dart:core';
import 'dart:ffi';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'location_event.dart';

part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationState()) {
    on<GetUserCurrentLocation>(getUserCurrentLocation);
    on<UpdateCurrentLocation>(updateCurrentLocation);
    on<OnCameraMove>(onCameraMove);
    
  }


  //Fetching Users Current Location
  FutureOr<void> getUserCurrentLocation(GetUserCurrentLocation event,
      Emitter<LocationState> emit) async {
    emit(state.copyWith(isLoadingstatus: true));
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(state.copyWith(errorMessage: "Location Service are enabled"));
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.deniedForever) {
          emit(state.copyWith(errorMessage: "Location Permission Denied"));
        }
      }

      Position position = await Geolocator.getCurrentPosition();
      LatLng currentPosition = LatLng(position.latitude, position.longitude);

      String address = await _getAddressFromLatLng(currentPosition);

      emit(state.copyWith(
          position: currentPosition,
          isLoadingstatus: false,
          address: address
      ));
    }
    catch (e) {
      emit(state.copyWith(
          errorMessage: "Failed to get the Location", isLoadingstatus: false));
    }
  }


  //To update the current Location  - Draggable Marker
  FutureOr<void> updateCurrentLocation(UpdateCurrentLocation event,
      Emitter<LocationState> emit) async {
    String newAddress = await _getAddressFromLatLng(event.position);
    emit(state.copyWith(
        position: event.position,
        address: newAddress
    ),);
  }


  //Function to get the address from latitude and longitude
   Future<String> _getAddressFromLatLng(LatLng position) async {
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark place = placemarks[0];
    return "${place.name}, ${place.subLocality},"
        " ${place.locality}, ${place.postalCode}, ${place
        .administrativeArea}, ${place.country}";
  }


  //Getting Position on Camera Move
  FutureOr<void> onCameraMove(OnCameraMove event, Emitter<LocationState> emit) {
    emit(state.copyWith(position: event.position));
  }
}
