class UserInfo {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  String get fullName => '$firstName $lastName';

  const UserInfo({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
  });

  /// Factory method to create a UserInfo instance from JSON
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  /// Factory method for creating an empty instance (default state)
  factory UserInfo.empty() {
    return const UserInfo(
      firstName: '',
      lastName: '',
      email: '',
      phone: '',
    );
  }

  /// Convert UserInfo instance to JSON format
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
    };
  }

  /// CopyWith method for updating specific fields
  UserInfo copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  }) {
    return UserInfo(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }
}
