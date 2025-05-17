part of 'location_bloc.dart';

class LocationState extends Equatable {
  final LatLng? position;
  final String? errorMessage;
  final String? locality;
  final String? area;
  final String? street;
  final String? city;
  final String? address;
  final bool isLoadingstatus;

  const LocationState(
      {this.position,
      this.errorMessage,
      this.isLoadingstatus = true,
      this.locality,
      this.area,
      this.street,
      this.address,
      this.city});

  LocationState copyWith({
    LatLng? position,
    String? errorMessage,
    bool? isLoadingstatus,
    String? locality,
    String? area,
    String? street,
    String? city,
    String? address,
  }) {
    return LocationState(
        position: position ?? this.position,
        errorMessage: errorMessage ?? this.errorMessage,
        isLoadingstatus: isLoadingstatus ?? this.isLoadingstatus,
        locality: locality ?? this.locality,
        area: area ?? this.area,
        street: street ?? this.street,
        city: city ?? this.city,
        address: address ?? this.address);
  }

  @override
  List<Object?> get props => [
        position,
        errorMessage,
        isLoadingstatus,
        area,
        street,
        city,
        locality,
        address
      ];
}
