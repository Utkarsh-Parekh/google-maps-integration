import 'package:demaze_practical/screens/maps/bloc/address-bloc/address_bloc.dart';
import 'package:demaze_practical/screens/maps/bloc/address-bloc/address_event.dart';
import 'package:demaze_practical/screens/maps/bloc/location-bloc/location_bloc.dart';
import 'package:demaze_practical/screens/maps/constants/maps_constants.dart';
import 'package:demaze_practical/screens/maps/model/address_model.dart';
import 'package:demaze_practical/screens/maps/widgets/receiver_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                color: Colors.black),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  MapsConstants.deliveryOrderLocation,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.blue,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.red,
                    ),
                    Flexible(
                      child: Text(
                        state.address.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push('/changeAddress');
                      },
                      child: Text(
                        MapsConstants.changeConst,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.red),
                      ),
                    )
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _showBottomSheet(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text(
                      MapsConstants.addMoreAddress,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}


//Model Bottom Sheet that enables user to add New Addresses
void _showBottomSheet(BuildContext context) {
  TextEditingController line1Controller = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    // backgroundColor: Colors.black,
    isDismissible: false,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  MapsConstants.entercompleteAddress,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                    onTap: () => context.pop(), child: Icon(Icons.close))
              ],
            ),
            const SizedBox(height: 20),

            //Widget that gives User infos Full Name & Phone Number of User
            const ReceiverDetails(),

            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: line1Controller,
              decoration: InputDecoration(
                labelText: MapsConstants.completeAddressConst,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.purple)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.purple)
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: areaController,
              decoration: InputDecoration(
                labelText: MapsConstants.areaLabelconst,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.purple)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.purple)
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: landmarkController,
              decoration: InputDecoration(
                labelText: MapsConstants.landMarkLabelconst,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.purple)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.purple)
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final newAddress = AddressModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    address: line1Controller.text,
                    area: areaController.text,
                    landmark: landmarkController.text,
                  );
                  context.read<AddressBloc>().add(SaveAddress(newAddress));
                  context.pop();
                },
                child: const Text(MapsConstants.confirmAddressconst),
              ),
            ),
          ],
        ),
      );
    },
  );
}
