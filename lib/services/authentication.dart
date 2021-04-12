import 'package:firebase_auth/firebase_auth.dart';

// Anonymous login
class Login {
  final FirebaseAuth _firebaseAuth;

  Login(this._firebaseAuth);

  Stream<User?>? user;

  Stream<User>? get authStateChanges {
    user = _firebaseAuth.authStateChanges();
  }

  Future<String?> anonymousLogin() async {
    try {
      await _firebaseAuth.signInAnonymously();
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}