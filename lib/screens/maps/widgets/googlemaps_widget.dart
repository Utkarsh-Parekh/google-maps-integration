import 'package:demaze_practical/screens/maps/bloc/location-bloc/location_bloc.dart';
import 'package:demaze_practical/screens/maps/constants/maps_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsWidget extends StatefulWidget {
  const GoogleMapsWidget({super.key});

  @override
  State<GoogleMapsWidget> createState() => _GoogleMapsWidgetState();
}

//Google Maps screen and Markers
class _GoogleMapsWidgetState extends State<GoogleMapsWidget> {
  late GoogleMapController mapController;
  LatLng? _currentPos;
  String? Maptheme = 'maps_theme/dark_theme.json';

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('maps_theme/dark_theme.json')
        .then((value) {
      Maptheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(builder: (context, state) {
      return GoogleMap(

          //Takes user current Location latitude and longitude
          initialCameraPosition: CameraPosition(
            target: LatLng(state.position?.latitude ?? 0.0,
                state.position?.longitude ?? 0.0),
            zoom: 14,
          ),

          //Provides Theme to the Maps
          style: Maptheme!,
          onMapCreated: (controller) {
            mapController = controller;
          },

          //When camera moves this function called every time
          onCameraMove: (positionValue) {
            _currentPos = positionValue.target;
            context
                .read<LocationBloc>()
                .add(OnCameraMove(positionValue.target));
          },
          onCameraIdle: () {
            if (_currentPos != null) {
              context
                  .read<LocationBloc>()
                  .add(UpdateCurrentLocation(_currentPos!));
            }
          },
          myLocationEnabled: true,
          markers: {
            Marker(
              markerId: const MarkerId('CurrentLocation'),
              position: state.position ?? const LatLng(0.0, 0.0),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueViolet,
              ),
              draggable: true,
              onDragEnd: (newPosition) {
                context
                    .read<LocationBloc>()
                    .add(UpdateCurrentLocation(newPosition));
                mapController
                    .animateCamera(CameraUpdate.newLatLng(newPosition));
                Future.delayed(const Duration(milliseconds: 500), () {
                  mapController
                      .showMarkerInfoWindow(const MarkerId('CurrentLocation'));
                });
              },
              infoWindow: const InfoWindow(
                title: MapsConstants.orderDeliveryConst,
                snippet: MapsConstants.movePinDeliveryConst,
              ),
            ),
          });
    });
  }
}
