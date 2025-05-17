import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final String? fullName;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final bool isLoading;
  final bool isProfileAvailable;

  const ProfileState(
      {this.firstName,
      this.lastName,
      this.fullName,
      this.email,
      this.phoneNumber,
      this.isLoading = true,
      this.isProfileAvailable = false});

  ProfileState copyWith(
      {String? firstName,
      String? lastName,
      String? fullName,
      String? email,
      String? phoneNumber,
      bool? isLoading,
      bool? isProfileAvailable}) {
    return ProfileState(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        isLoading: isLoading ?? this.isLoading,
        isProfileAvailable: isProfileAvailable ?? this.isProfileAvailable);
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        fullName,
        email,
        phoneNumber,
        isLoading,
        isProfileAvailable
      ];
}
