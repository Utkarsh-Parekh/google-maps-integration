import 'package:demaze_practical/screens/maps/bloc/location-bloc/location_bloc.dart';
import 'package:demaze_practical/screens/maps/constants/maps_constants.dart';
import 'package:demaze_practical/screens/maps/widgets/address_widget.dart';
import 'package:demaze_practical/screens/maps/widgets/googlemaps_widget.dart';
import 'package:demaze_practical/screens/maps/widgets/searchbar_widget.dart';
import 'package:demaze_practical/screens/profile/bloc/profile_bloc.dart';
import 'package:demaze_practical/screens/profile/bloc/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  @override
  void initState() {
    context.read<LocationBloc>().add(GetUserCurrentLocation());
    context.read<ProfileBloc>().add(FetchProfileDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(MapsConstants.confirmAddressHeader,
            style: Theme.of(context).textTheme.titleLarge!),
      ),
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state.isLoadingstatus) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Stack(
            fit: StackFit.expand,
            children: [
              const GoogleMapsWidget(),

              //SearchBar Widget
              const SearchBarWidget(),

              //Widget that shows current Location based on Camera Movement
              const AddressWidget(),

              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.20,
                right: 60,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.my_location),
                    onPressed: () {
                      //Event that fetched current Location of User
                      context
                          .read<LocationBloc>()
                          .add(GetUserCurrentLocation());
                    },
                    label: const Text(MapsConstants.useCurrentlocationSelect),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(width: 2, color: Colors.green),
                      foregroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
