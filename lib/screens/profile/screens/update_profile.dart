import 'package:demaze_practical/core/services/notification_services.dart';
import 'package:demaze_practical/screens/profile/bloc/profile_bloc.dart';
import 'package:demaze_practical/screens/profile/bloc/profile_event.dart';
import 'package:demaze_practical/screens/profile/bloc/profile_state.dart';
import 'package:demaze_practical/screens/profile/constants/profile_constants.dart';
import 'package:demaze_practical/screens/profile/provider/image_provider.dart';
import 'package:demaze_practical/screens/profile/widgets/image_picker_widget.dart';
import 'package:demaze_practical/screens/profile/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(FetchProfileDetails());
    super.initState();
  }

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImagePickerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return Text(
                state.isProfileAvailable ? ProfileConstants.editProfileConst : ProfileConstants.createProfileConst,
                style: Theme.of(context).textTheme.titleLarge!);
          },
        ),
        leading: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: const Icon(LineAwesomeIcons.angle_left_solid)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Stack(
                children: [
                  const ImagePickerWidget(),
                  Positioned(
                    bottom: 0,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        imageProvider.pickImage();
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(100)),
                        child: const Icon(LineAwesomeIcons.camera_retro_solid),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    firstNameController.text = state.firstName ?? '';
                    lastNameController.text = state.lastName ?? '';
                    emailController.text = state.email ?? '';
                    phoneController.text = state.phoneNumber ?? '';
                  }

                  return Form(
                    key: _key,
                      child: Column(
                    children: [
                      TextFieldWidget(
                          controller: firstNameController,
                          icon: LineAwesomeIcons.user,
                        label: ProfileConstants.firstNameLabel,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ProfileConstants.firstNameValid;
                          }
                        },

                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWidget(
                        controller: lastNameController,
                        icon: LineAwesomeIcons.user,
                        label: ProfileConstants.LastNameLabel,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ProfileConstants.lastNameValid;
                          }
                        },

                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWidget(
                          controller: emailController,
                          icon: LineAwesomeIcons.mail_bulk_solid,
                        label: ProfileConstants.emailIdConst
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWidget(
                        controller: phoneController,
                        icon: LineAwesomeIcons.phone_alt_solid,
                        isNumber: true,
                        label: ProfileConstants.phoneNumberConst,
                      )
                    ],
                  ));
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  if(_key.currentState!.validate()){
                    NotificationServices().showNotifications(
                      title: 'Profile Updated',
                      body: 'Your profile has been successfully updated.',
                      // imagePath: 'lib/assets/user.jpg',
                    );

                    context.read<ProfileBloc>().add(
                      SaveProfileDetails(
                        firstName: firstNameController.text.trimLeft(),
                        lastName: lastNameController.text.trimLeft(),
                        email: emailController.text,
                        phoneNumber: phoneController.text,
                      ),
                    );

                    context.pop();
                  }

                },
                style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                child: Text(
                  ProfileConstants.saveProfile,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
