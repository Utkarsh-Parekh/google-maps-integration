import 'package:demaze_practical/screens/maps/model/address_model.dart';

abstract class AddressEvent {}


class SaveAddress extends AddressEvent {
  final AddressModel address;
  SaveAddress(this.address);
}

class FetchSavedAddresses extends AddressEvent {}

class DeleteAddress extends AddressEvent{
  final String id;
  DeleteAddress(this.id);
}
