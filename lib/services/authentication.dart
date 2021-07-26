import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

enum LoginState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
}
// Anonymous login
class Login extends ChangeNotifier {
  Login(this._firebaseAuth) {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = LoginState.loggedIn;
      } else {
        _loginState = LoginState.loggedOut;
      }
      notifyListeners();
    });
  }

  LoginState _loginState = LoginState.loggedOut;
  LoginState get loginState => _loginState;



  final FirebaseAuth _firebaseAuth;

  Stream<User?>? userState;

  Stream<User>? get authStateChanges {
    userState = _firebaseAuth.authStateChanges();
  }

  Future<String?> anonymousLogin() async {
    try {
      await _firebaseAuth.signInAnonymously();
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  void registerAccount(String email, String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }
}

