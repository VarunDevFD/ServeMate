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

  Future<User?> signUpWithEmailPassword(String email, String password,) async {
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
              'Sign-up failed: The email is already registered with the same role.');
        } else {
          // Add new role entry for the same email
          await _addUserToFirestore(email, role, null);
          log("Added new role for existing email: $email with role: $role");
          return null;
        }
      }

      // Email does not exist; create new Firebase account
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Add user to Firestore with email and role
      await _addUserToFirestore(email, role, userCredential.user?.uid);
      log("New user created with email: $email and role: $role");
    } on FirebaseAuthException catch (e) {
      throw Exception('Sign-up failed: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
    return null;
  }

  Future<void> _addUserToFirestore(
      String email, String role, String? uid) async {
    final userId = uid ?? firebaseAuth.currentUser?.uid;

    if (userId == null) {
      throw Exception(
          'User ID is null. Unable to store user details in Firestore.');
    }

    // Add a new Firestore document with a unique ID for each role
    await firestore.collection('users').doc().set({
      'uid': userId,
      'email': email,
      'role': role,
    });

    await pref.setHasSeenCategory(true);

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
