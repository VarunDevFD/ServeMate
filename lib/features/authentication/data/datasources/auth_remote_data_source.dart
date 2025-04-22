import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/core/repositories/preferences_repository.dart';
import 'package:serve_mate/core/utils/app_exception.dart';
import 'package:serve_mate/core/utils/helper/helper_auth_fn.dart';
import 'package:serve_mate/features/authentication/data/models/user_model.dart';

abstract class AuthDataSource {
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithEmailPassword(String email, String password);
  Future<UserModel?> signUpWithEmailPassword(UserModel user);
  Future<void> signOut();
}

class AuthRemoteDataSource implements AuthDataSource {
  final firebaseAuth = serviceLocator<FirebaseAuth>();
  final googleSignIn = serviceLocator<GoogleSignIn>();
  final firestore = serviceLocator<FirebaseFirestore>();
  final pref = serviceLocator<PreferencesRepository>();

  //--------------------------Sin-Up-Email-&-Password---------------------------

  @override
  Future<UserModel?> signUpWithEmailPassword(UserModel user) async {
    const String role = "ServiceProvider";
    try {
      // Check if the email exists in Firestore
      final querySnapshot = await firestore
          .collection('users')
          .doc(role)
          .collection(role)
          .where('email', isEqualTo: user.email)
          .where('googleSignIn', isEqualTo: false)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        throw const AppException(
          details: 'Email already exists',
          alert: 'Sign-up failed: The email is already registered.',
        );
      }

      if (user.password == null || user.password!.isEmpty) {
        throw const AppException(
          details: 'Password is empty',
          alert: 'Sign-up failed: Password cannot be empty.',
        );
      }

      final modEmail = Helpers.concatenateWithNewEmail(user.email);

      // Email does not exist; create new Firebase account
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: modEmail, password: user.password!);

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        throw const AppException(
          details: 'User credential is null',
          alert: 'Sign-up failed: User credential is null.',
        );
      }
      final userModel = UserModel(
        id: firebaseUser.uid,
        email: modEmail,
        name: user.name,
        password: user.password,
        role: user.role ?? role,
        createdAt: DateTime.now(),
        photoUrl: user.photoUrl,
      );

      // Add user to Firestore with email and role
      await _addUserToFirestore(userModel);

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw AppException(
        details: e.toString(),
        alert: 'Sign-up failed: ${e.message}',
      );
    } catch (e) {
      throw AppException(
        details: e.toString(),
        alert: 'An error occurred during sign-up.',
      );
    }
  }

  Future<void> _addUserToFirestore(UserModel user) async {
    final userId = user.id;

    if (userId == null) {
      throw const AppException(
        details: 'User ID is null',
        alert: 'Sign-up failed: User ID is null.',
      );
    }

    await firestore
        .collection('users')
        .doc(user.role)
        .collection(user.role!)
        .doc(userId)
        .set({
      'uid': userId,
      'photoUrl': user.photoUrl,
      'email': user.email,
      'name': user.name,
      'password': user.password,
      'categoryName': user.categoryName,
      'categories': user.categorys,
      'time': user.createdAt?.toIso8601String(),
      'googleSignIn': user.googleSignIn ?? false,
    });

    await pref.setUSerId(userId);
    await pref.setCategoryScreen(true);
  }

  //--------------------------------Sin-In-Email-&-Password---------------------

  @override
  Future<UserModel> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      const String role = "ServiceProvider";
      final modEmail = Helpers.concatenateWithNewEmail(email);
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: modEmail,
        password: password,
      );
      await pref.setUSerId(userCredential.user!.uid);
      // await pref.setCategoryScreen(true);
      final user = userCredential.user;
      if (user == null) {
        throw const AppException(
          details: 'Sign-in failed',
          alert: 'No user found for the provided credentials.',
        );
      }

      final doc = await firestore
          .collection('users')
          .doc(role)
          .collection(role)
          .doc(user.uid)
          .get();

      if (!doc.exists) {
        throw const AppException(
          details: 'User data not found',
          alert: 'User data not found in Firestore. Please sign up first.',
        );
      }

      final userModel = UserModel.fromFirestore(doc.data()!, user.uid);
      return userModel;
    } on FirebaseAuthException catch (e) {
      throw AppException(
        details: e.toString(),
        alert: 'Sign-in failed: ${e.message}',
      );
    } catch (e) {
      throw AppException(
        details: e.toString(),
        alert: 'An error occurred during sign-in.',
      );
    }
  }

  //---------------------------Sign-In-Google-----------------------------------

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      const String role = "ServiceProvider";
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw const AppException(
          details: 'Google sign-in aborted',
          alert: 'Google sign-in was cancelled.',
        );
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential =
          await firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final UserModel userModel = UserModel(
          id: user.uid,
          email: user.email ?? googleUser.email,
          name: user.displayName ?? googleUser.displayName ?? 'Anonymous',
          photoUrl: user.photoURL ?? googleUser.photoUrl,
          password: null,
          categoryName: null,
          categorys: null,
          googleSignIn: true,
          createdAt: DateTime.now(),
          role: role,
        );
        await _addUserToFirestore(userModel);
        return userModel;
      } else {
        throw const AppException(
          details: 'Google sign-in failed',
          alert: 'Failed to authenticate with Google.',
        );
      }
    } on FirebaseAuthException catch (e) {
      throw AppException(
        details: e.toString(),
        alert: 'Google sign-in failed: ${e.message}',
      );
    } catch (e) {
      throw AppException(
        details: e.toString(),
        alert: 'An error occurred during Google sign-in.',
      );
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

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut(); // Sign out from Firebase
      await googleSignIn.signOut(); // Sign out from Google
      await pref.removeUserId(); // Remove user ID from preferences
      await pref.removeHasSeenHome(); // Remove home preference
      await pref.removeCategoryScreen(); // Remove category preference
    } catch (e) {
      throw Exception('AuthRemoteDataSource - Sign out failed: $e');
    }
  }
}
