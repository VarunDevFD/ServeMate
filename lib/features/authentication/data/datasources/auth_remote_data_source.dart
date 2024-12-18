import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/features/authentication/domain/entities/user_entity.dart';

class AuthRemoteDataSource {
  final firebaseAuth = serviceLocator<FirebaseAuth>();
  final googleSignIn = serviceLocator<GoogleSignIn>();
  final firestore = serviceLocator<FirebaseFirestore>();
  final pref = serviceLocator<PreferencesRepository>();

  //--------------------------Sin-Up-Email-&-Password---------------------------

  Future<String?> signUpWithEmailPassword(
    String name,
    String email,
    String password,
  ) async {
    const String role = "ServiceProvider";
    try {
      // Check if the email exists in Firestore
      final querySnapshot = await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Email already exists
        final roles =
            querySnapshot.docs.map((doc) => doc.data()['role']).toList();

        if (roles.contains(role)) {
          // Email exists with the same role
          throw Exception(
            'Sign-up failed: The email is already registered with the same role.',
          );
        } else {
          // Add new role entry for the same email
          await _addUserToFirestore(name, email, password, role, null);
          log("Added new role for existing email: $email with role: $role");
          return null;
        }
      }

      // Email does not exist create new Firebase account
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Add user to Firestore with email and role
      await _addUserToFirestore(
        name,
        email,
        password,
        role,
        userCredential.user?.uid,
      );
      log("New user created with email: $email and role: $role");
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "Password should be at least 6 characters.";
      } else if (e.code == 'email-already-in-use') {
        return "The email address is already in use.";
      } else if (e.code == 'invalid-email') {
        return "The email address is not valid.";
      } else {
        return "Sign-up failed: ${e.message}";
      }
    } catch (e) {
      return "An unexpected error occurred: $e";
    }
  }

  Future<void> _addUserToFirestore(
    String name,
    String email,
    String password,
    String role,
    String? uid,
  ) async {
    final userId = uid ?? firebaseAuth.currentUser?.uid;

    if (userId == null) {
      throw Exception(
          'User ID is null. Unable to store user details in Firestore.');
    }

    // Add a new Firestore document with a unique ID for each role
    await firestore.collection('users').doc('serivceProvider\$$userId').set({
      'uid': userId,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
    });

    await pref.setHasSeenCategory(true); //
    await pref.setHasSeenUserId([userId]);

    log("User added to Firestore: $email with role $role");
  }

  //--------------------------------Sign-In-------------------------------------

  Future<AuthUser?> signInWithEmailPassword(
      String email, String password) async {
    const String role = "ServiceProvider";

    try {
      // Authenticate using Firebase Authentication
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Query Firestore to check if email and role exist
      final querySnapshot = await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .where('role', isEqualTo: role)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception(
            'Sign-in failed: No user found with the provided email and role.');
      }

      await pref.setHasSeenCategory(true);

      // Return authenticated user if all checks pass
      return userCredential.user != null
          ? AuthUser(
              id: userCredential.user!.uid,
              email: userCredential.user!.email!,
              role: role,
            )
          : null;
    } on FirebaseAuthException catch (e) {
      throw Exception('Sign-in failed: ${e.message}');
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  //--------------------------SignUp --Get the User ----------------------------

  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  //---------------------------Sign-In-Google-----------------------------------

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign in failed');
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential =
          await firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase exceptions
      throw Exception(
          'AuthRemoteDataSource - Google sign in failed: ${e.message}');
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  //-------------------------Forgot-Password------------------------------------

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  //-------------------------Sign-Out-------------------------------------------

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut(); // Sign out from Firebase
      await googleSignIn.signOut(); // Sign out from Google
    } catch (e) {
      throw Exception('AuthRemoteDataSource - Sign out failed: $e');
    }
  }
}
