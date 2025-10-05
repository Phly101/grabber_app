
import 'package:firebase_auth/firebase_auth.dart';

class VerificationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user == null) {
      print("Error: No user logged in");
      throw Exception("No user logged in");
    }
    if (user.emailVerified) {
      print("Error: Email is already verified for ${user.email}");
      throw Exception("Email is already verified");
    }

    try {
      await user.sendEmailVerification(ActionCodeSettings(
        url: "https://your-app.firebaseapp.com", // Replace with your Firebase Dynamic Links URL
        handleCodeInApp: true,
      ));
      print("Verification email sent to: ${user.email}");
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: ${e.code} - ${e.message}");
      throw Exception(e.message ?? "Failed to send verification email");
    } catch (e) {
      print("Unexpected error: $e");
      throw Exception("Failed to send verification email: $e");
    }
  }

  Future<bool> checkEmailVerified() async {
    try {
      await _auth.currentUser?.reload();
      final freshUser = _auth.currentUser;
      print("Checking email verification for ${freshUser?.email}: ${freshUser?.emailVerified}");
      return freshUser?.emailVerified ?? false;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException in checkEmailVerified: ${e.code} - ${e.message}");
      throw Exception(e.message ?? "Failed to check verification");
    } catch (e) {
      print("Unexpected error in checkEmailVerified: $e");
      throw Exception("Failed to check verification: $e");
    }
  }
}