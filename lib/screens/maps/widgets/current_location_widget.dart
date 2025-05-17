import 'package:demaze_practical/screens/maps/bloc/location-bloc/location_bloc.dart';
import 'package:demaze_practical/screens/maps/constants/maps_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CurrentLocationWidget extends StatelessWidget {
  const CurrentLocationWidget({super.key});

  //Widget that Provides Current Location & Add Address Functionality
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.deepPurple.shade500,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.green,
                ),
                const SizedBox(width: 10),
                BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                         MapsConstants.useCurrentlocationSelect,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(

                          width:MediaQuery.of(context).size.width / 1.5,

                          child: Text(
                            state.address!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                          )
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(color: Colors.grey),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () => context.pop(),
            child: Row(
              children: [
                const Icon(
                  Icons.add,
                  color: Colors.green,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    MapsConstants.addAddress,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.green, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
