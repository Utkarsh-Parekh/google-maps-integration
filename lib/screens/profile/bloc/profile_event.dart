import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProfileDetails extends ProfileEvent {}

class SaveProfileDetails extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  SaveProfileDetails({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });
}
