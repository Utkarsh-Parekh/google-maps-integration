import 'package:demaze_practical/screens/maps/bloc/address-bloc/address_bloc.dart';
import 'package:demaze_practical/screens/maps/bloc/address-bloc/address_event.dart';
import 'package:demaze_practical/screens/maps/bloc/address-bloc/address_state.dart';
import 'package:demaze_practical/screens/maps/constants/maps_constants.dart';
import 'package:demaze_practical/screens/maps/widgets/current_location_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class AddressDetails extends StatelessWidget {
  const AddressDetails({super.key});

  //Widget that shows all Saved Addresses
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error != null) {
              return Center(child: Text(state.error!));
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: const Icon(
                              LineAwesomeIcons.arrow_circle_down_solid)),
                      const SizedBox(width: 20),
                      Text(
                        MapsConstants.locationSelect,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  //Widget that Provides Current Location & Add Address Functionality
                  const CurrentLocationWidget(),

                  const SizedBox(height: 20),

                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                          endIndent: 10,
                        ),
                      ),
                      Text(
                        MapsConstants.saveAddressConst,
                        style: TextStyle(
                          letterSpacing: 3,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey,
                          indent: 10, // Add some spacing at the start
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // Show Saved Addresses
                  Expanded(
                    child: state.savedAddresses == null ||
                            state.savedAddresses!.isEmpty
                        ? const Center(
                            child: Text(MapsConstants.noAddressAvailableConst))
                        : ListView.builder(
                            itemCount: state.savedAddresses!.length,
                            itemBuilder: (context, index) {
                              final address = state.savedAddresses![index];
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.deepPurple.shade500,
                                ),
                                padding: const EdgeInsets.all(20),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.home),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          address.address ??
                                              MapsConstants.noAddress,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.5,
                                          child: Text(
                                            '${address.area}, ${address.landmark}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () => context
                                              .read<AddressBloc>()
                                              .add(DeleteAddress(state
                                                  .savedAddresses![index].id)),
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
