import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:serve_mate/features/authentication/domain/entities/user_entity.dart';

class UserModel {
  final String? id;
  final String email;
  final String? name;
  final String? password;
  final String? categoryName;
  final List<String>? categorys;
  final String? photoUrl;
  final String? role;
  final DateTime? createdAt;
  final bool? googleSignIn;

  UserModel({
    this.id,
    required this.email,
    this.name,
    this.password,
    this.categoryName,
    this.categorys,
    this.photoUrl,
    this.role,
    this.createdAt,
    this.googleSignIn,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> data, String id) {
    return UserModel(
      id: id,
      email: data['email'] as String,
      name: data['name'] as String?,
      password: data['password'] as String?,
      categoryName: data['categoryName'] as String?,
      categorys: (data['categorys'] as List<dynamic>?)?.map((e) => e as String).toList(),
      photoUrl: data['photoUrl'] as String?,
      role: data['role'] as String?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      googleSignIn: data['googleSignIn'] as bool?,
    );
  }

  AuthUser toEntity() {
    return AuthUser(
      id: id,
      email: email,
      name: name,
      password: password,
      categoryName: categoryName,
      categorys: categorys,
      photoUrl: photoUrl,
      role: role,
      createdAt: createdAt,
      googleSignIn: googleSignIn,
    );
  }

  factory UserModel.fromEntity(UserModel user) {
    return UserModel(
      id: user.id,
      email: user.email,
      name: user.name,
      password: user.password,
      categoryName: user.categoryName,
      categorys: user.categorys,
      photoUrl: user.photoUrl,
      role: user.role,
      createdAt: user.createdAt,
      googleSignIn: user.googleSignIn,
    );
  }
}
