import 'package:serve_mate/features/profile/data/model/user_model.dart';

class UserEntity {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? phone;
  final String? location;
  final String? profileImageUrl;
  final String? quote;

  UserEntity({
    this.id,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.location,
    this.profileImageUrl,
    this.quote,
  });

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? phone,
    String? location,
    String? profileImageUrl,
    String? quote,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      quote: quote ?? this.quote,
    );
  }

  static UserEntity empty() {
    return UserEntity(
      id: '1',
      name: 'Varun pc',
      email: 'Varunrevathi6@gmail.com',
      password: 'v123456@',
      phone: '9037526089',
      location: 'Kerala, India',
      profileImageUrl: null,
      quote: 'Best luck for your future',
    );
  }

  static UserModel fromEntity(UserModel user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      password: user.password,
      phone: user.phone,
      location: user.location,
      profileImageUrl: user.profileImageUrl,
      quote: user.quote,
    );
  }
}
