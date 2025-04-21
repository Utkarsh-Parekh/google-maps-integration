import 'package:demaze_practical/core/provider/theme_provider.dart';
import 'package:demaze_practical/screens/authentication/services/auth_services.dart';
import 'package:demaze_practical/screens/profile/bloc/profile_bloc.dart';
import 'package:demaze_practical/screens/profile/bloc/profile_state.dart';
import 'package:demaze_practical/screens/profile/constants/profile_constants.dart';
import 'package:demaze_practical/screens/profile/provider/image_provider.dart';
import 'package:demaze_practical/screens/profile/widgets/image_picker_widget.dart';
import 'package:demaze_practical/screens/profile/widgets/profile_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  void initState() {
    context.read<ImagePickerProvider>().fetchProfileImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //uncomment to check the APP base DARK & LIGHT THEME
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(ProfileConstants.ProfileConst,
            style: Theme.of(context).textTheme.titleLarge!),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const ImagePickerWidget(),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                return Visibility(
                  visible: state.isProfileAvailable,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push("/updateprofile");
                    },
                    style:
                        ElevatedButton.styleFrom(shape: const StadiumBorder()),
                    child: Text(
                      ProfileConstants.editProfileConst,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return state.isProfileAvailable
                    ? SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ProfileConstants.fullNameConst,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              ProfileDetailsWidget(
                                  value: state.fullName!.isNotEmpty
                                      ? state.fullName!
                                      : " - "),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                ProfileConstants.emailIdConst,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              ProfileDetailsWidget(
                                  value: state.email!.isNotEmpty
                                      ? state.email!
                                      : " - "),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                ProfileConstants.phoneNumberConst,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              ProfileDetailsWidget(
                                  value: state.phoneNumber!.isNotEmpty
                                      ? state.phoneNumber!
                                      : " - "),
                              const SizedBox(
                                height: 20,
                              ),

                              //DARK & LIGHT THEME CHANGES
                              // Container(
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(10),
                              //     border:
                              //         Border.all(color: Colors.deepPurple, width: 1),
                              //   ),
                              //   width: MediaQuery.of(context).size.width * 1,
                              //   height: 50,
                              //   padding: const EdgeInsets.all(10),
                              //   alignment: Alignment.center,
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Text(
                              //         "Dark Mode",
                              //         style: Theme.of(context)
                              //             .textTheme
                              //             .titleLarge!
                              //             .copyWith(fontWeight: FontWeight.w600),
                              //       ),
                              //       Switch(
                              //         value:
                              //             themeProvider.themedata == ThemeMode.dark,
                              //         activeColor: Colors.white,
                              //         onChanged: (value) {
                              //           themeProvider.toggleTheme(value);
                              //         },
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          context.push("/updateprofile");
                        },
                        child: Text(
                          ProfileConstants.createProfileConst,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ));
              },
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                AuthService().signOut(context);
              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.red, width: 1),
                  ),
                  width: MediaQuery.of(context).size.width * 1,
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text(ProfileConstants.logOutConst,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w700))),
            ),
          ],
        ),
      ),
    );
  }
}
