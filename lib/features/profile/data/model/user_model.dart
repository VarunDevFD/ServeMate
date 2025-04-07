class UserModel {
  final String id;
  final String name;
  final String email;
  final String? password;
  final String? phone;
  final String? location;
  final String? profileImageUrl;
  final String? quote;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    this.phone,
    this.location,
    this.profileImageUrl,
    this.quote,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String?,
      location: json['location'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      quote: json['quote'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'location': location,
      'profileImageUrl': profileImageUrl,
      'quote': quote,
    };
  }
}
