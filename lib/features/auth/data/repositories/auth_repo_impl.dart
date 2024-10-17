import 'package:firebase_auth/firebase_auth.dart';
import 'package:serve_mate/features/auth/data/models/firbase_auth_model.dart';
import 'package:serve_mate/features/auth/domain/entities/user_entities.dart';
import 'package:serve_mate/features/auth/domain/repositories/auth_repo.dart';

class FirebaseAuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthRepositoryImpl(this.firebaseAuth);

  @override
  Future<UserEntity> signInWithEmailPassword(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return FirebaseUserModel.fromFirebase(userCredential.user!);
  }

  @override
  Future<UserEntity> registerWithEmailPassword(String email, String password) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return FirebaseUserModel.fromFirebase(userCredential.user!);
  }
}
