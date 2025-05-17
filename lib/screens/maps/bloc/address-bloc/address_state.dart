import 'package:demaze_practical/screens/maps/model/address_model.dart';

class AddressState {
  final List<AddressModel>? savedAddresses;
  final bool isLoading;
  final String? error;

  AddressState({
    this.savedAddresses,
    this.isLoading = true,
    this.error,
  });

  AddressState copyWith({
    List<AddressModel>? savedAddresses,
    String? error,
    bool? isLoading,
  }) {
    return AddressState(
        savedAddresses: savedAddresses ?? this.savedAddresses,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error);
  }
}
