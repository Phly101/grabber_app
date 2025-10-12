
import 'package:firebase_auth/firebase_auth.dart';

class VerificationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception("No user logged in");
    }
    if (user.emailVerified) {
      throw Exception("Email is already verified");
    }

    try {
      await user.sendEmailVerification(ActionCodeSettings(
        url: "https://grabber-7f649.firebaseapp.com",
        handleCodeInApp: true,
      ));
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "Failed to send verification email");
    } catch (e) {
      throw Exception("Failed to send verification email: $e");
    }
  }

  Future<bool> checkEmailVerified() async {
    try {
      await _auth.currentUser?.reload();
      final freshUser = _auth.currentUser;
      return freshUser?.emailVerified ?? false;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "Failed to check verification");
    } catch (e) {
      throw Exception("Failed to check verification: $e");
    }
  }
}