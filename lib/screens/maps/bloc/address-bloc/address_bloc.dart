import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demaze_practical/screens/maps/bloc/address-bloc/address_event.dart';
import 'package:demaze_practical/screens/maps/bloc/address-bloc/address_state.dart';
import 'package:demaze_practical/screens/maps/model/address_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AddressBloc() : super(AddressState()) {
    on<SaveAddress>(_onAddAddress);
    on<FetchSavedAddresses>(_onFetchAddresses);
    on<DeleteAddress>(_onDeleteAddress);
  }

  //Add Addresses to Firebase
  Future<void> _onAddAddress(
      SaveAddress event, Emitter<AddressState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      await _firestore
          .collection('Addresses')
          .doc(event.address.id)
          .set(event.address.toMap());
      add(FetchSavedAddresses()); // Refresh the address list
    } catch (e) {
      emit(state.copyWith(error: "Failed to add address"));
    }
  }

  //Fetching the saved Addresses from Firebase
  Future<void> _onFetchAddresses(
      FetchSavedAddresses event, Emitter<AddressState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final querySnapshot = await _firestore.collection('Addresses').get();
      final addresses = querySnapshot.docs
          .map((doc) => AddressModel.fromMap(doc.data()))
          .toList();
      emit(state.copyWith(savedAddresses: addresses, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: "Failed to fetch addresses"));
    }
  }

  // Delete the Address
  Future<void> _onDeleteAddress(
      DeleteAddress event, Emitter<AddressState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      await _firestore.collection('Addresses').doc(event.id).delete();
      add(FetchSavedAddresses()); // Refresh the address list
    } catch (e) {
      emit(state.copyWith(error: "Failed to delete address"));
    }
  }
}
