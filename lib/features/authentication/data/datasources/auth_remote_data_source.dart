import 'dart:developer';

// import 'package:crypto/crypto.dart'; // For SHA-256 hashing (you can use other hashing methods like bcrypt)
// import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';

class AuthRemoteDataSource {
  final firebaseAuth = serviceLocator<FirebaseAuth>();
  final googleSignIn = serviceLocator<GoogleSignIn>();
  final firestore = serviceLocator<FirebaseFirestore>();
  final pref = serviceLocator<PreferencesRepository>();

  //--------------------------Sin-Up-Email-&-Password---------------------------

  Future<void> signUpWithEmailPassword(
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
          return;
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
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific exceptions
      if (e.code == 'weak-password') {
        log("Sign-up failed: Weak password.");
        throw Exception("Password should be at least 6 characters.");
      } else if (e.code == 'email-already-in-use') {
        log("Sign-up failed: Email already in use.");
        throw Exception("The email address is already in use.");
      } else if (e.code == 'invalid-email') {
        log("Sign-up failed: Invalid email address.");
        throw Exception("The email address is not valid.");
      } else {
        log("Sign-up failed: ${e.message}");
        throw Exception("Sign-up failed: ${e.message}");
      }
    } catch (e) {
      // Handle any other exceptions
      log("An unexpected error occurred: $e");
      throw Exception("An unexpected error occurred: $e");
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
    await firestore.collection('users').doc('serivceProvider$userId').set({
      'uid': userId,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'time': FieldValue.serverTimestamp(),
    });

    await pref.setHasSeenCategory(true); //
    await pref.setHasSeenUserId([userId]);

    log("User added to Firestore: $email with role $role");
  }

  //--------------------------------Sign-In-------------------------------------

  Future<bool> signInWithEmailPassword(
    String email,
    String password,
    String role,
  ) async {
    try {
      // Get all documents
      final allDocsSnapshot = await firestore.collection('users').get();

      // Indicate the matching document is found
      bool isUserFound = false;

      // Iterate over all documents to check for matching data
      for (var doc in allDocsSnapshot.docs) {
        final Map<String, dynamic> userData = doc.data(); // Convert doc -> Map

        // Check if the document matches the criteria
        if (userData['email'] == email &&
            userData['password'] == password &&
            userData['role'] == role) {
          log("User Found: ${userData['name']}, Role: ${userData['role']}");
          isUserFound = true;
        }
      }

      // No user
      if (!isUserFound) {
        log("No user found with the provided credentials.");
      }

      return isUserFound; // Return true if a match is found, otherwise false
    } catch (e) {
      throw Exception('Sign-in failed: $e');
    }
  }

  // /// Helper function to hash passwords
  // String _hashPassword(String password) {
  //   final bytes = utf8.encode(password); // Convert to UTF-8
  //   final digest = sha256.convert(bytes); // Hash using SHA-256
  //   return digest.toString(); // Return the hashed password
  // }

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
