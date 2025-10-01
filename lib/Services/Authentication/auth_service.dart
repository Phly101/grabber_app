import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:shared_preferences/shared_preferences.dart";

class AuthResult {
  final User? user;
  final String? error;
  final String? message;

  AuthResult({this.user, this.error,this.message,});

  bool get isSuccess => user != null && error == null;
}

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthService({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firebaseFireStore,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
       _firebaseFirestore = firebaseFireStore ?? FirebaseFirestore.instance;

  // Listen for user changes
  Stream<User?> get user => _firebaseAuth.authStateChanges();

  // function sing up
  Future<AuthResult?> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String city,
  }) async {

    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // set to the user collection data  which some of them is not included in the signup
      final user = credential.user;
      if (user != null) {
        await _firebaseFirestore.collection("users").doc(user.uid).set({
          "city": city,
          "email": user.email,
          "name": name,
          "phoneNumber": phone,
        }, SetOptions(merge: true));
      } else {
        throw Exception("No user is currently signed in.");
      }

      return AuthResult(user: credential.user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return AuthResult(error: "This email is already registered.");
        case "invalid-email":
          return AuthResult(error: "The email address is not valid.");
        case "weak-password":
          return AuthResult(error: "The password is too weak.");
        default:
          return AuthResult(error: e.message);
      }
    } catch (e) {
      return AuthResult(error: e.toString());
    }
  }

  // function sign in
  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await saveUserLocally(credential.user!);

      return AuthResult(user: credential.user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          return AuthResult(error: "No user found for that email.");
        case "wrong-password":
          return AuthResult(error: "Wrong password provided.");
        case "invalid-credential":
          return AuthResult(error: "Account not found. Please, sign up.");
        default:
          return AuthResult(error: e.message ?? "An unknown error occurred.");
      }
    }
  }

  // sign out function
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // remove saved login info
  }

  // function reAuthentication
  Future<void> reAuthenticate({
    required String currentEmail,
    required String currentPassword,
  }) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception("No user is currently signed in.");
    }
    final AuthCredential credential = EmailAuthProvider.credential(
      email: currentEmail,
      password: currentPassword,
    );
    await user.reauthenticateWithCredential(credential);
  }

  // update password function
  Future<void> updatePassword({
    required String newPassword,
    required String currentPassword,
  }) async {
    final user = _firebaseAuth.currentUser;
    if (user != null && user.email != null) {
      await reAuthenticate(
        currentEmail: user.email!,
        currentPassword: currentPassword,
      );
      await user.updatePassword(newPassword);
    }
  }

  Future<AuthResult> forgotPassword(String email) async{
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return AuthResult(message: "Password reset email sent successfully.");
    } on FirebaseAuthException catch (e) {

     return AuthResult(error: e.message ?? "An unknown Error occurred");
    }

  }


  //_____________________________________________________________________Shared preferences code

  // Save user data in SharedPreferences
  Future<void> saveUserLocally(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", true);
    await prefs.setString("uid", user.uid);
    await prefs.setString("email", user.email ?? "");
  }

  // Check if user is already logged in
  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    return _firebaseAuth.currentUser != null && isLoggedIn;
  }
}
