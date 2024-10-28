import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'package:serve_mate/features/authentication/domain/entities/user_entity.dart';

class AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth = serviceLocator<FirebaseAuth>();
  final GoogleSignIn googleSignIn = serviceLocator<GoogleSignIn>();

  //--------------------------Sin-Up-Email-&-Password---------------------------

  Future<User?> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception('AuthRemoteDataSource - Sign up failed: ${e.message}');
    } catch (e) {
      throw Exception('AuthRemoteDataSource - An unknown error occurred: $e');
    }
  }

  //--------------------------------Sign-In-------------------------------------

  Future<AuthUser?> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user != null
          ? AuthUser(
              id: userCredential.user!.uid, email: userCredential.user!.email!)
          : null;
    } on FirebaseAuthException catch (e) {
      throw Exception('AuthRemoteDataSource - Sign in failed: ${e.message}');
    } catch (e) {
      throw Exception('AuthRemoteDataSource - An unknown error occurred: $e');
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
        throw Exception('Google sign in aborted');
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
       UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
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
