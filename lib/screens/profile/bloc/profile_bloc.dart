import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demaze_practical/screens/profile/bloc/profile_event.dart';
import 'package:demaze_practical/screens/profile/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  ProfileBloc() : super(ProfileState()) {
    on<FetchProfileDetails>(fetchProfileDetails);
    on<SaveProfileDetails>(saveProfileDetails);
  }

  //Fetches User Profile Information
  FutureOr<void> fetchProfileDetails(
      FetchProfileDetails event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final doc = await firestore.collection('profile').doc('utkarsh').get();
      if (doc.exists && doc.data() != null) {
        final details = doc.data()!;
        emit(state.copyWith(
            fullName: details['fullName'],
            email: details['email'] ?? '',
            phoneNumber: details['phoneNumber'] ?? '',
            firstName: details['firstName'] ?? '',
            lastName: details['lastName'] ?? '',
            isLoading: false,
            isProfileAvailable: true));
      } else {
        emit(state.copyWith(isLoading: false, isProfileAvailable: false));
        print('Document does not exist.');
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      print('Error fetching profile details: $e');
    }
  }

  //Saves User Profile Details
  FutureOr<void> saveProfileDetails(
      SaveProfileDetails event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true));

    //Task : 3 : User Details to Json
    await firestore.collection('profile').doc('utkarsh').set({
      'fullName': event.firstName + " " + event.lastName,
      'email': event.email,
      'phoneNumber': event.phoneNumber,
      'firstName': event.firstName,
      'lastName': event.lastName
    });

    emit(state.copyWith(
        fullName: "${event.firstName} ${event.lastName}",
        email: event.email,
        firstName: event.firstName,
        lastName: event.lastName,
        phoneNumber: event.phoneNumber,
        isProfileAvailable: true,
        isLoading: false));
  }
}
