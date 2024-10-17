import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:serve_mate/features/auth/domain/entities/user_entity.dart';

class AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSource({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  Future<AuthUser?> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user != null
          ? AuthUser(
              id: userCredential.user!.uid, email: userCredential.user!.email!)
          : null;
    } on FirebaseAuthException catch (e) {
      // Handle Firebase specific exceptions
      throw Exception('Sign in failed: ${e.message}');
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  //--------------------------SignUp --Get the User ----------------------------

  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

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
      // Handle specific Firebase exceptions
      throw Exception('Sign up failed: ${e.message}');
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
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
      return (await firebaseAuth.signInWithCredential(credential)).user;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase exceptions
      throw Exception('Google sign in failed: ${e.message}');
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  //-------------------------Forgot-Password------------------------------------

  Future<void> resetPassword(String email) async {
    try {
      // Send the password reset email
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      // Throw an AppException with the error details and an alert message
      throw Exception('reset password problem: ${e.toString()}');
    }
  }

  //-------------------------Sign-Out-------------------------------------------

  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut(); // Sign out from Firebase
      await googleSignIn.signOut(); // Sign out from Google
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }
}
