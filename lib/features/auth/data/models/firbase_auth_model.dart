import 'package:firebase_auth/firebase_auth.dart';
import 'package:serve_mate/features/auth/domain/entities/user_entities.dart';

class FirebaseUserModel extends UserEntity {
  // No need to declare uid and email again since they are already declared in UserEntity

  FirebaseUserModel(
      {required super.uid, required super.email}); // Explicit super call

  factory FirebaseUserModel.fromFirebase(User user) {
    return FirebaseUserModel(
      uid: user.uid, // Accessing uid directly from the constructor
      email: user.email ?? '', // Providing default if email is null
    );
  }
}
