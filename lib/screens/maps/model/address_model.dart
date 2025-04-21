
//Address Model
class AddressModel {
  final String id;
  final String? address;
  final String? landmark;
  final String? area;

  AddressModel({
    required this.id,
    this.address,
    this.landmark,
    this.area
  });

  AddressModel copyWith({
    String? id,
    String? address,
    String? landmark,
    String? area

  }) {
    return AddressModel(
      id: id ?? this.id,
      address: address ?? this.address,
      landmark: landmark ?? this.landmark,
      area: area ?? this.area
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address':address,
      'landmark':landmark,
      'area': area,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] ?? '',
      address: map['address'] ?? '',
      landmark: map['landmark'] ?? '',
      area: map['area'],
    );
  }
}
