import 'package:demaze_practical/screens/maps/constants/maps_constants.dart';
import 'package:demaze_practical/screens/profile/bloc/profile_bloc.dart';
import 'package:demaze_practical/screens/profile/bloc/profile_event.dart';
import 'package:demaze_practical/screens/profile/bloc/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ReceiverDetails extends StatefulWidget {
  const ReceiverDetails({super.key});

  @override
  State<ReceiverDetails> createState() => _ReceiverDetailsState();
}

class _ReceiverDetailsState extends State<ReceiverDetails> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
  builder: (context, state) {
    return Container(
      width: MediaQuery.of(context).size.width * 1.5,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.purple),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(MapsConstants.receiverDetailsconstAddress,style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Colors.grey
          )),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(LineAwesomeIcons.phone_alt_solid),
              const SizedBox(
                width: 10,
              ),
              Text("${state.fullName ?? "First Name"}, ",style: Theme.of(context).textTheme.bodyLarge,),

              Text(state.phoneNumber ?? "PhoneNo",style: Theme.of(context).textTheme.bodyLarge,)
            ],
          )
        ],
      ),
    );
  },
);
  }
}
